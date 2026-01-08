module Api
  module V1
    class OrderItemPerformersController < Api::V1::ApplicationController
      include Pundit::Authorization

      before_action :set_resource, only: %i[update destroy]
      before_action :authorize_resource!

      def create
        @resource = OrderItemPerformer.new(resource_params)

        if @resource.save
          render json: OrderItemPerformerSerializer.new(@resource), status: :created
        else
          error_response
        end
      end

      def update
        if @resource.update(resource_params)
          render json: OrderItemPerformerSerializer.new(@resource)
        else
          error_response
        end
      end

      def destroy
        @resource.destroy!
        head :no_content
      end

      private

      def set_resource
        @resource = OrderItemPerformer.find_by!(
          order_id: params[:order_id],
          order_item_id: params[:order_item_id],
          id: params[:id]
        )
      end

      def authorize_resource!
        authorize @resource || OrderItemPerformer
      end

      def resource_params
        params.expect(order_item_performer: %i[order_item_id performer_id performer_type performer_fee role])
      end
    end
  end
end
