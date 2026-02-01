module Avito
  class SenderService
    def initialize(text, chat_id, **args)
      @text = text
      @chat_id = chat_id
      @type = args[:type] || 'text'
    end

    def self.call(text, chat_id, **args)
      new(text, chat_id, **args).call
    end

    def call
      set_avito
      set_account
      url = msg_url(1)
      raise "Unknown message type: #{@type}" unless %w[text].include?(@type)

      payload = { message: { text: @text }, type: @type }
      fetch_and_parse(url, :post, payload)
      1
    end

    private

    def msg_url(version = 3)
      "https://api.avito.ru/messenger/v#{version}/accounts/#{@account['id']}/chats/#{@chat_id}/messages"
    end

    def set_account
      @account = fetch_cached(:account_avito, 6.hours, url: 'https://api.avito.ru/core/v1/accounts/self')
    end

    def fetch_cached(key, expires_in = 5.minutes, **args)
      result = Rails.cache.fetch(key, expires_in:) do
        fetch_and_parse(args[:url], args[:method] || :get, args[:payload])
      end
      Rails.cache.delete(key) if result.is_a?(Hash) && result.key?(:error)
      result
    end

    def fetch_and_parse(url, method = :get, payload = nil)
      response = @avito.connect_to(url, method, payload)
      return { 'error' => "Ошибка подключения к API Avito. Статус: #{response&.status}" } unless response&.success?

      JSON.parse(response.body)
    rescue JSON::ParserError => e
      { 'error' => "Ошибка парсинга JSON: #{e.message}" }
    end

    def set_avito
      @avito = AvitoService.new
      return if @avito.token_status.nil? || @avito.token_status == 200

      error_notice t('avito.error.set_avito')
    end
  end
end
