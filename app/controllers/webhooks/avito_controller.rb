module Webhooks
  class AvitoController < Webhooks::ApplicationController
    def create
      # author_id = params.dig(:payload, :value, :author_id)
      # return head :ok if author_id.to_i == ENV.fetch('AVITO_ACCOUNT_ID').to_i

      InboundWebhookJob.perform_later(:avito, params.to_unsafe_h)

      head :ok
    end
  end
end
