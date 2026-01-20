module Webhooks
  class TelegramController < Webhooks::ApplicationController
    def create
      InboundWebhookJob.perform_later(:telegram, params.to_unsafe_h)

      head :ok
    end
  end
end
