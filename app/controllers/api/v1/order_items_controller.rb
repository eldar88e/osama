module Api
  module V1
    class OrderItemsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def authorize_resource!
        authorize @resource || OrderItem
      end

      def resource_class
        binding.irb
        Order.find(params[:order_id])&.order_items
      end

      def serializer
        OrderItemSerializer
      end

      def resource_params
        params.expect(
          order_item: %i[order_id service_id performer_id performer_type state price paid comment materials_price
                         materials_comment delivery_price delivery_comment]
        )
      end
    end
  end
end
