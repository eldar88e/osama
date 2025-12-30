module Api
  module V1
    class OrderItemsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def set_resource
        order     = Order.find(params[:order_id])
        @resource = order.order_items.find(params[:id])
      end

      def order_params
        params.expect(
          order: %i[order_id service_id performer_id performer_type state price paid comment materials_price
                    materials_comment delivery_price delivery_comment]
        )
      end
    end
  end
end
