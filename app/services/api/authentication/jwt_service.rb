require 'jwt'

module Api
  module Authentication
    class JwtService
      SECRET     = Rails.application.secret_key_base
      ALG        = 'HS256'.freeze
      ACCESS_TTL = 15.minutes

      Result = Struct.new(:payload, :error, keyword_init: true)

      def self.encode(payload)
        payload[:exp] = ACCESS_TTL.from_now.to_i
        JWT.encode(payload, SECRET, ALG)
      end

      def self.decode(token)
        payload = JWT.decode(token, SECRET, true, algorithm: ALG)[0]
        Result.new(payload: payload.with_indifferent_access)
      rescue JWT::ExpiredSignature
        Result.new(error: 'token_expired')
      rescue JWT::DecodeError
        Result.new(error: 'invalid_token')
      end
    end
  end
end
