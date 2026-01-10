class OrderShowSerializer
  include Alba::Resource

  root_key :order

  attributes :id, :state, :paid, :price, :expense, :comment, :appointment_at,
             :processing_at, :completed_at, :cancelled_at, :updated_at, :created_at

  many :order_items, resource: OrderItemSerializer
  one :client, resource: UserSerializer
end
