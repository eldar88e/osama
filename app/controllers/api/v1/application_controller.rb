module Api
  module V1
    class ApplicationController < ActionController::API
      respond_to :json

      include ApiAuth
      include Pagy::Method

      before_action :authenticate_access!

      private

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
