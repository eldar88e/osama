class OrderItemSerializer
  include Alba::Resource

  root_key :order_item

  attributes :id, :order_id, :service_id, :state, :paid, :price,
             :materials_price, :materials_comment, :delivery_price, :delivery_comment, :comment,
             :updated_at, :created_at

  one :performer, resource: lambda { |performer|
    case performer
    when User
      UserSerializer
    when Contactor
      ContactorsSerializer
    end
  }
end
