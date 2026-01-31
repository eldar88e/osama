module Webhooks
  module Avito
    class InboundMessageService
      def self.call(payload)
        raise NotImplementedError, 'Avito webhook handling not implemented yet'
      rescue StandardError => e
        Rails.logger.error "Avito webhook error: #{e.message}"
        Rails.logger.error payload
        nil
      end
    end
  end
end
