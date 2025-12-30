module Api
  module V1
    class ApplicationController < ActionController::API
      respond_to :json

      rescue_from ActionController::ParameterMissing, with: :render_bad_request
      rescue_from Pundit::NotAuthorizedError, with: :render_forbidden
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      include Api::Auth
      include Pagy::Method

      before_action :authenticate_access!, except: :not_found

      def not_found
        render json: { error: 'not_found' }, status: :not_found
      end

      private

      def render_bad_request(e)
        render json: {
          error: 'bad_request',
          message: e.message
        }, status: :bad_request
      end

      def render_forbidden
        render json: { error: 'forbidden' }, status: :forbidden
      end

      def pagy_metadata(pagy)
        { count: pagy.count, from: pagy.from, in: pagy.in, last: pagy.last,
          limit: pagy.limit, offset: pagy.offset, page: pagy.page }
      end

      # rubocop:disable Naming/MemoizedInstanceVariableName
      def settings
        @settings_ ||= Setting.all_cached
      end
      # rubocop:enable Naming/MemoizedInstanceVariableName
    end
  end
end
