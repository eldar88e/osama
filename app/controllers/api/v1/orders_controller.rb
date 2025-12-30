module Api
  module V1
    class OrdersController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def order_params
        params.expect(order: %i[user_id car_id state paid comment appointment_at])
      end
    end
  end
end
