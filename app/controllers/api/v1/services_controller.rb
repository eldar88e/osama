module Api
  module V1
    class ServicesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def service_params
        params.expect(service: %i[title active])
      end
    end
  end
end
