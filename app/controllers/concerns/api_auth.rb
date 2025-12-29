module ApiAuth
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user, :current_session
  end

  private

  def authenticate_access!
    header = request.headers['Authorization']
    token  = header&.split(' ')&.last
    result = Api::Authentication::JwtService.decode(token)
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
end
