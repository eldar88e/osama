module Webhooks
  module Telegram
    module Handlers
      class MessageHandler
        def self.call(payload)
          new(payload).call
        end

        def initialize(payload)
          @payload = payload
        end

        def call
          message = @payload['message'] || @payload['edited_message']
          raise 'No message payload' unless message

          conversation = find_or_create_conversation(message)
          create_message(conversation, message)
          send_first_message(conversation.external_id) if message['text'] == '/start'
        rescue ActiveRecord::RecordNotUnique
          nil
        end

        private

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

        def create_message(conversation, message)
          Message.create!(
            conversation: conversation,
            direction: :incoming,
            external_id: message['message_id'].to_s,
            text: message['text'] || message['caption'] || 'Неизвестный тип сообщения',
            published_at: Time.zone.at(message['date']),
            payload: message
          )
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

        def send_first_message(sender_id)
          TelegramJob.perform_later(
            msg: 'Добро пожаловать в Автоателье Birson! Что вас интересует?',
            id: sender_id
          )
        end
      end
    end
  end
end
