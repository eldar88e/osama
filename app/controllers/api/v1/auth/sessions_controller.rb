module Api
  module V1
    module Auth
      class SessionsController < Api::V1::ApplicationController
        EXPIRES_IN = 14.days

        respond_to :json

        skip_before_action :authenticate_access!, only: :create

        def create
          @current_user = User.find_by(email: user_params[:email])
          return unauthorized('email_or_pass_invalid') unless current_user&.valid_password?(user_params[:password])

          raw_refresh, digest = Api::Authentication::RefreshTokenService.generate
          session             = create_session(digest)

          render json: tokens(raw_refresh, session.id)
        end

        def refresh
          # session = ApiSession.active.find_by(id: params[:session_id])
          # return unauthorized unless session
          #
          # unless RefreshTokenService.match?(params[:refresh_token], session.refresh_token_digest)
          #   session.revoke!
          #   return unauthorized
          # end
          #
          # session.revoke! # rotation
          #
          # raw_refresh, digest = RefreshTokenService.generate
          # new_session = session.user.api_sessions.create!(
          #   refresh_token_digest: digest,
          #   user_agent: request.user_agent,
          #   ip: request.remote_ip
          # )
          #
          # render json: tokens(session.user, raw_refresh, new_session.id)
        end

        def destroy
          current_session&.revoke!
          head :no_content
        end

        private

        def create_session(digest)
          current_user.api_sessions.create!(
            refresh_token_digest: digest,
            user_agent: request.user_agent,
            ip: request.remote_ip,
            expires_at: EXPIRES_IN.from_now
          )
        end

        def tokens(refresh, session_id)
          {
            access_token: Api::Authentication::JwtService.encode(user_id: current_user.id, session_id: session_id),
            refresh_token: refresh,
            user_id: current_user.id
          }
        end

        def user_params
          params.expect(user: %i[email password])
        end
      end
    end
  end
end
