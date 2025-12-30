class OrderSerializer
  include Alba::Resource

  # root_key :order

  attributes :id, :user_id, :car_id, :state, :paid, :price, :expense, :comment, :appointment_at,
             :processing_at, :completed_at, :cancelled_at, :updated_at, :created_at
end
