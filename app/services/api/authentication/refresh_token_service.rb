require 'bcrypt'

module Api
  module Authentication
    class RefreshTokenService
      def self.generate
        raw    = SecureRandom.uuid
        digest = BCrypt::Password.create(raw)
        [raw, digest]
      end

      def self.match?(raw, digest)
        BCrypt::Password.new(digest).is_password?(raw)
      end
    end
  end
end
