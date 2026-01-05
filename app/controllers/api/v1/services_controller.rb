module Api
  module V1
    class ServicesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def service_params
        params.expect(car: %i[title])
      end
    end
  end
end
