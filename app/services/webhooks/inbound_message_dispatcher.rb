class InboundMessageDispatcher
  def self.call(source:, payload:)
    case source.to_sym
    when :telegram
      Webhooks::Telegram::InboundMessageService.call(payload)
    when :avito
      Webhooks::Avito::InboundMessageService.call(payload)
    else
      raise "Unknown source: #{source}"
    end
  end
end
