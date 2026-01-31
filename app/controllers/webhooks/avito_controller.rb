module Webhooks
  class AvitoController < Webhooks::ApplicationController
    def create
      Rails.logger.error '=' * 20
      Rails.logger.warn params
      Rails.logger.error '=' * 20
      InboundWebhookJob.perform_later(:avito, params.to_unsafe_h)

      head :ok
    end
  end
end
