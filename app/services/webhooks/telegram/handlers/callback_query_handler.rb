module Webhooks
  module Telegram
    module Handlers
      class CallbackQueryHandler
        def self.call(payload)
          new(payload).call
        end

        def initialize(payload)
          @payload = payload
        end

        def call
          raise 'No implemented callback_query handler'
          # TODO: Handle callback query
        end
      end
    end
  end
end
