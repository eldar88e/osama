module Api
  module V1
    class OrdersController < Api::V1::ApplicationController
      include Api::ResourceConcern

      def index
        q = policy_scope(Order).order(:created_at).includes(:client, :car).ransack(params[:q])

        pagy, resources = pagy(q.result)

        render json: { data: OrderSerializer.new(resources), meta: pagy_metadata(pagy) }
      end

      def show
        render json: OrderShowSerializer.new(@resource)
      end

      private

      # rubocop:disable Rails/StrongParametersExpect
      def order_params
        params.require(:order).permit(
          :client_id, :state, :paid, :comment, :appointment_at,
          order_items_attributes: [
            :id, :service_id, :state, :price, :paid, :comment, :materials_price,
            :materials_comment, :delivery_price, :delivery_comment, :performer_fee, :_destroy,
            { order_item_performers_attributes: %i[id performer_id performer_type performer_fee _destroy] }
          ]
        )
      end
      # rubocop:enable Rails/StrongParametersExpect
    end
  end
end
