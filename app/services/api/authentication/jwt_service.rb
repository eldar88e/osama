require 'jwt'

module Api
  module Authentication
    class JwtService
      SECRET     = Rails.application.secret_key_base
      ALG        = 'HS256'.freeze
      ACCESS_TTL = 15.minutes

      def self.encode(payload)
        payload[:exp] = ACCESS_TTL.from_now.to_i
        JWT.encode(payload, SECRET, ALG)
      end

      def self.decode(token)
        JWT.decode(token, SECRET, true, algorithm: ALG)[0].with_indifferent_access
      rescue JWT::ExpiredSignature, JWT::DecodeError
        nil
      end
    end
  end
end
