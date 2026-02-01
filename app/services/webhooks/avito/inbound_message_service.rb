module Webhooks
  module Avito
    class InboundMessageService
      ALLOV_MESSAGE_TYPES = %w[text image].freeze

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
        unless @payload['payload']['type'] == 'message'
  raise StandardError, "Unknown Avito webhook type: #{@payload['payload']['type']}"
end

          message = @payload.dig('payload', 'value')
          save_message message
        
          
        
      end

      private

      def save_message(message)
        conversation = find_or_create_conversation(message)
        create_message(conversation, message)
        return if ALLOV_MESSAGE_TYPES.include?(message['type'])

        raise StandardError, "Unknown message type #{message['type']}"
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

      def create_message(conversation, message)
        start_data = {
          conversation: conversation,
          direction: :incoming,
          external_id: message['id'],
          published_at: Time.zone.at(message['created'])
        }
        data = make_message_data(message)
        Message.create!(start_data.merge(data))
      end

      def make_message_data(message)
        binding.irb
        case message['type']
        when 'text'
          { text: message.dig('content', 'text') }
        when 'image'
          { msg_type: 'image', data: { image_url: message.dig('content', 'image', 'sizes', '1280x960') } }
        else
          { payload: message }
        end
      end
    end
  end
end
