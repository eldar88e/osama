require 'faraday'

class AvitoService
  TOKEN_URL     = 'https://api.avito.ru/token'.freeze
  CLIENT_ID     = ENV.fetch('AVITO_CLIENT_ID').freeze
  CLIENT_SECRET = ENV.fetch('AVITO_CLIENT_SECRET').freeze

  def initialize
    @token_status = nil
    @token        = fetch_token
    @headers      = { 'Authorization' => "Bearer #{@token}", 'Content-Type' => 'application/json' }
  end

  attr_reader :token_status, :token

  def connect_to(url, method = :get, payload = nil, **args)
    return if @token.blank? && args[:headers].blank?

    send_request(url, method, payload, **args)
  rescue StandardError => e
    Rails.logger.error e.message
    nil
  end

  private

  def send_request(url, method, payload, **args)
    request    = method == :get || args[:url_encoded] ? :url_encoded : :json
    connection = Faraday.new(url:) do |faraday|
      faraday.request request
      faraday.response :logger if Rails.env.development?
      faraday.adapter Faraday.default_adapter
    end

    connection.send(method) do |req|
      req.headers = args[:headers] || @headers
      req.body    = args[:form] ? payload : payload.to_json if payload
    end
  end

  def fetch_token
    result = Rails.cache.fetch(:avito_token, expires_in: 23.hours) { refresh_token }
    Rails.cache.delete(:avito_token) if result.blank?
    result
  end

  def refresh_token
    payload = URI.encode_www_form(
      { grant_type: 'client_credentials', client_id: CLIENT_ID, client_secret: CLIENT_SECRET }
    )
    headers  = { 'Content-Type' => 'application/x-www-form-urlencoded' }
    params   = { headers:, form: true, url_encoded: true }
    response = connect_to(TOKEN_URL, :post, payload, **params)
    return log_bad_token(response) unless response.success?

    parse_token(response)
  end

  def parse_token(response)
    token_info = JSON.parse(response.body)
    token_info['access_token']
  end

  def log_bad_token(response)
    Rails.logger.error "Failed to get token! Status: (#{response.status}), Error: #{response.body}"
    @token_status = response.status
    nil
  end
end
