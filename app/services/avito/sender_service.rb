module Avito
  class SenderService
    ALLOWED_MESSAGE_TYPES = %w[text image].freeze

    def initialize(text, chat_id, **args)
      @text       = text
      @chat_id    = chat_id
      @type       = args[:type] || ALLOWED_MESSAGE_TYPES[0]
      @uploadfile = args[:uploadfile]
    end

    def self.call(text, chat_id, **args)
      new(text, chat_id, **args).call
    end

    def call
      set_avito
      set_account
      return send_file_message if @uploadfile.present?
      raise "Unknown message type: #{@type}" unless ALLOWED_MESSAGE_TYPES.include?(@type)

      url = message_url
      result = fetch_and_parse(url, :post, { message: { text: @text }, type: @type })
      raise 'Unknow message_id for Avito send message' if result&.dig('id').blank?

      { msg_type: result['type'], id: result['id'], published_at: Time.zone.at(result['created']) }
    rescue StandardError => error
      Rails.logger.error "Avito::SenderService error: #{error.message}"
      error
    end

    private

    def message_url
      "https://api.avito.ru/messenger/v1/accounts/#{@account['id']}/chats/#{@chat_id}/messages"
    end

    def set_account
      @account = fetch_cached(:account_avito, 1.day, url: 'https://api.avito.ru/core/v1/accounts/self')
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

    def send_file_message
      url     = "https://api.avito.ru/messenger/v1/accounts/#{@account['id']}/uploadImages"
      payload = {
        'uploadfile' => Faraday::UploadIO.new(@uploadfile.path, @uploadfile.content_type, @uploadfile.original_filename)
      }
      headers  = { 'Authorization' => "Bearer #{@avito.token}" }
      response = @avito.connect_to(url, :post, payload, headers: headers, multipart: true)

      image        = JSON.parse response.body
      image_id     = image.keys.first.to_s
      url_img_send = "https://api.avito.ru/messenger/v1/accounts/#{@account['id']}/chats/#{@chat_id}/messages/image"
      result = fetch_and_parse(url_img_send, :post, { image_id: image_id })

      { msg_type: result['type'], id: result['id'], published_at: Time.zone.at(result['created']),
        data: { image_url: result['content']['image']['sizes']['1280x960'] } }
    rescue StandardError => error
      Rails.logger.error "Avito::SenderService send_file_message error: #{error.message}"
      error
    end
  end
end
