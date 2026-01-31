module Webhooks
  class AvitoController < Webhooks::ApplicationController
    def create
      InboundWebhookJob.perform_later(:avito, params.to_unsafe_h)

      head :ok
    end
  end
end
