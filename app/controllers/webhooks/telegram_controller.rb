module Webhooks
  class TelegramController < Webhooks::ApplicationController
    def create
      # InboundWebhookJob.perform_later(:telegram, params.to_unsafe_h)
      # #####
      Rails.logger.warn "Telegram message received: #{params.to_unsafe_h}"
      InboundMessageDispatcher.call(source: :telegram, payload: params.to_unsafe_h)
      # #####

      head :ok
    end
  end
end
