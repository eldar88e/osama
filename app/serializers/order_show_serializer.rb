class OrderShowSerializer
  include Alba::Resource

  root_key :order

  attributes :id, :client_id, :state, :paid, :price, :expense, :comment, :appointment_at,
             :processing_at, :completed_at, :cancelled_at, :updated_at, :created_at, :deposit, :paid_at

  attribute :client_full_name do |order|
    order.client&.full_name
  end

  many :order_items, resource: OrderItemSerializer
end
