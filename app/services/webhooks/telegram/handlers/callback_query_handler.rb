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
          # TODO: Handle callback query
        end
      end
    end
  end
end
