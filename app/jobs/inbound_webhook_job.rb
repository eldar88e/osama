class InboundWebhookJob < ApplicationJob
  queue_as :default

  def perform(source, payload)
    Webhooks::InboundMessageDispatcher.call(
      source: source,
      payload: payload
    )
  end
end
