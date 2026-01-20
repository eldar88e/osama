module Webhooks
  class ApplicationController < ActionController::API
    def create
      InboundWebhookJob.perform_later(:telegram, params.to_unsafe_h)
      head :ok
    end
  end
end
