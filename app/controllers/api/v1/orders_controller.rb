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

      def order_params
        params.expect(order: %i[client_id car_id state paid comment appointment_at])
      end
    end
  end
end
