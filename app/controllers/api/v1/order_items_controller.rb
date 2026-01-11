module Api
  module V1
    class OrderItemsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def authorize_resource!
        authorize @resource || OrderItem
      end

      def resource_class
        Order.find(params[:order_id])&.order_items
      end

      def serializer
        OrderItemSerializer
      end

      # rubocop:disable Rails/StrongParametersExpect
      def resource_params
        params.require(:order_item).permit(
          :order_id, :car_id, :service_id, :state, :price, :paid, :comment, :materials_price,
          :materials_comment, :delivery_price, :delivery_comment,
          order_item_performers_attributes: %i[
            id performer_id performer_type performer_fee role _destroy
          ]
        )
      end
      # rubocop:enable Rails/StrongParametersExpect
    end
  end
end
