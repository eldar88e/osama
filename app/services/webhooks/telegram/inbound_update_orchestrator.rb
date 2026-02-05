module Webhooks
  module Telegram
    class InboundUpdateOrchestrator
      def self.call(payload)
        if payload['message'] || payload['edited_message']
          Webhooks::Telegram::Handlers::MessageHandler.call(payload)
        elsif payload['callback_query']
          Webhooks::Telegram::Handlers::CallbackQueryHandler.call(payload['callback_query'])
        else
          save_undefined_type_message(payload)
          Rails.logger.error "Unknown Telegram update: #{payload.keys}"
        end
      end

      private

      def save_undefined_type_message(payload)
        Message.create!(
          conversation: find_or_create_conversation(payload),
          direction: :incoming,
          external_id: payload['message_id'].to_s,
          text: 'Неизвестный тип сообщения',
          published_at: Time.zone.at(message['date']),
          payload: payload
        )
      end

      def find_or_create_conversation(message)
        tg_id = message.dig('chat', 'id')
        Conversation.find_or_create_by!(
          source: :telegram,
          external_id: tg_id.to_s
        ) do |c|
          c.meta = extract_meta(message)
          c.user = User.find_by(tg_id: tg_id)
        end
      end

      def extract_meta(message)
        from = message['from'] || {}

        {
          telegram_user_id: from['id'],
          username: from['username'],
          first_name: from['first_name'],
          last_name: from['last_name'],
          language: from['language_code'],
          photo_url: from['photo_url']
        }
      end
    end
  end
end
