class OrdersController < ApplicationController
  include ResourceConcerns

  def index; end

  private

  def order_params
    params.expect(order: %i[user_id car_id service_id status])
  end
end
