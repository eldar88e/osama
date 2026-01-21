module Webhooks
  module Telegram
    class InboundUpdateOrchestrator
      # rubocop:disable Metrics/MethodLength
      def self.call(payload)
        if payload['callback_query']
          Webhooks::Telegram::Handlers::CallbackQueryHandler.call(payload['callback_query'])
        elsif payload['message'] || payload['edited_message']
          Webhooks::Telegram::Handlers::MessageHandler.call(payload)
        else
          Rails.logger.error "Unknown Telegram update: #{payload.keys}"
          nil
        end
      rescue StandardError => e
        Rails.logger.error "Telegram webhook error: #{e.message}"
        nil
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
