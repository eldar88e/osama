module Api
  module Auth
    extend ActiveSupport::Concern

    included do
      attr_reader :current_user, :current_session
    end

    private

    def authenticate_access!
      result = decode_token
      return unauthorized(result.error) if result.error

      payload = result.payload
      @current_user = User.find_by(id: payload[:user_id])
      return unauthorized unless @current_user

      @current_session = ApiSession.authenticate(payload[:session_id], @current_user.id)
      unauthorized unless @current_session
    end

    def unauthorized(error = 'unauthorized')
      render json: { error: error }, status: :unauthorized
    end

    def decode_token
      header = request.headers['Authorization']
      token  = header&.split&.last
      Api::Authentication::JwtService.decode(token)
    end
  end
end
