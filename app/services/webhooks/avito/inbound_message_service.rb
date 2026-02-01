module Webhooks
  module Avito
    class InboundMessageService
      def initialize(payload)
        @payload = payload
      end

      def self.call(payload)
        new(payload).call
      rescue StandardError => e
        Rails.logger.error "Avito webhook error: #{e.message}"
        Rails.logger.error payload
        nil
      end

      def call
        if @payload['payload']['type'] == 'message'
          message = @payload.dig('payload', 'value')
          save_message message
        else
          raise StandardError, "Unknown Avito webhook type: #{@payload['payload']['type']}"
        end
      end

      private

      def save_message(message)
        conversation = find_or_create_conversation(message)
        if message['type'] != 'text'
          create_message(conversation, message)
          raise StandardError, 'Unknown message type'
        end

        create_message(conversation, message, message['content']['text'])
      end

      def find_or_create_conversation(message)
        Conversation.find_or_create_by!(
          source: :avito,
          external_id: message['chat_id']
        ) do |c|
          c.user = User.find_by(avito_id: message['author_id'])
          c.meta = { author_id: message['author_id'] }
        end
      end

      def create_message(conversation, message, text = nil)
        Message.create!(
          conversation: conversation,
          direction: :incoming,
          external_id: message['id'],
          text: text,
          published_at: Time.zone.at(message['created']),
          payload: text.nil? ? message : {}
        )
      end
    end
  end
end
