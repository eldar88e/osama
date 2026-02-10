module Api
  module V1
    class OrdersController < Api::V1::ApplicationController
      include Api::ResourceConcern

      before_action :change_state, only: :update

      def index
        q = policy_scope(Order).published.order(created_at: :desc).includes(:client).ransack(params[:q])

        pagy, resources = pagy(q.result)

        render json: { data: OrderSerializer.new(resources), meta: pagy_metadata(pagy) }
      end

      def show
        render json: OrderShowSerializer.new(@resource)
      end

      def create
        args = { draft: true }
        args[:client_id] = params[:order][:client_id] if params[:order][:client_id].present?
        @resource = Order.find_or_create_by!(args)
        @resource.update!(created_at: Time.current)

        render json: OrderShowSerializer.new(@resource)
      end

      def update
        @resource.draft = @resource.order_items.blank?
        if @resource.update(resource_params)
          render json: serializer.new(@resource)
        else
          error_response
        end
      end

      def statistics
        render json: Api::Dashboard::StatisticsService.new.call
      end

      private

      # rubocop:disable Rails/StrongParametersExpect
      def order_params
        params.require(:order).permit(
          :client_id, :state, :comment, :appointment_at,
          order_items_attributes: [
            :id, :service_id, :car_id, :state, :price, :paid, :comment, :materials_price,
            :materials_comment, :delivery_price, :delivery_comment, :_destroy,
            { order_item_performers_attributes: %i[id performer_id performer_type performer_fee _destroy] }
          ]
        )
      end
      # rubocop:enable Rails/StrongParametersExpect

      def change_state
        Api::Orders::ChangeStateService.call(@resource, params[:order][:state])
      end
    end
  end
end
