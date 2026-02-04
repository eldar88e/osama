module Api
  module V1
    class PositionsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def position_params
        params.expect(car: [:title])
      end
    end
  end
end
