class OrdersController < ApplicationController
  include ResourceConcerns

  private

  # rubocop:disable Rails/StrongParametersExpect
  def order_params
    params.require(:order).permit(
      :user_id, :car_id, :service_id, :state, :paid, :comment :appointment_at,
      order_items_attributes: %i[
        id service_id performer_id performer_type state price paid comment materials_price materials_comment
        delivery_price delivery_comment _destroy
      ]
    )
  end
  # rubocop:enable Rails/StrongParametersExpect
end
