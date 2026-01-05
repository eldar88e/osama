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
          :client_id, :car_id, :state, :paid, :comment, :appointment_at,
          order_items_attributes: %i[
            id service_id performer_id performer_type state price paid comment materials_price materials_comment
            delivery_price delivery_comment _destroy
          ]
        )
      end
      # rubocop:enable Rails/StrongParametersExpect
    end
  end
end
