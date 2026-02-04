module Api
  module V1
    class CarsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def car_params
        params.expect(car: %i[owner_id license_plate brand model vin year comment])
      end
    end
  end
end
