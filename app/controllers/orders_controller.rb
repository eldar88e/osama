class OrdersController < ApplicationController
  include ResourceConcerns

  private

  def order_params
    params.expect(order: %i[user_id car_id service_id state paid comment appointment_at])
  end
end
