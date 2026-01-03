class OrderSerializer
  include Alba::Resource

  root_key :order

  attributes :id, :client_id, :car_id, :state, :paid, :price, :expense, :comment, :appointment_at,
             :processing_at, :completed_at, :cancelled_at, :updated_at, :created_at

  attribute :client do |order|
    [order.client.first_name, order.client.middle_name].compact.join(' ')
  end

  attribute :car do |order|
    [order.car.brand, order.car.model].compact.join(' ')
  end
end
