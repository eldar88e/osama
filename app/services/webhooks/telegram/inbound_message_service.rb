module Webhooks
  module Telegram
    class InboundMessageService
      def self.call(payload)
        new(payload).call
      end

      def initialize(payload)
        @payload = payload
      end

      def call
        message_payload = payload['message'] || payload['edited_message']
        raise 'No message or edited_message in payload' unless message_payload

        conversation = find_or_create_conversation(message_payload)
        create_message(conversation, message_payload)
      rescue ActiveRecord::RecordNotUnique
        nil # Ignore duplicate messages
      rescue StandardError => e
        Rails.logger.error "Error processing Telegram message: #{e.message}"
        nil
      end

      private

      attr_reader :payload

      def find_or_create_conversation(message)
        Conversation.find_or_create_by!(
          source: :telegram,
          external_id: message.dig('chat', 'id').to_s
        ) do |c|
          c.meta = extract_meta(message)
        end
      end

      def create_message(conversation, message)
        Message.create!(
          conversation: conversation,
          direction: :incoming,
          external_id: message['message_id'].to_s,
          text: message['text'],
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
    end
  end
end
