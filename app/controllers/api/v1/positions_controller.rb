module Api
  module V1
    class PositionsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def position_params
        params.expect(position: [:title])
      end
    end
  end
end
