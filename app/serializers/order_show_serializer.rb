class OrderShowSerializer < OrderSerializer
  many :order_items, resource: OrderItemSerializer
end
