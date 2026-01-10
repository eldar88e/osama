class OrderItemSerializer
  include Alba::Resource

  root_key :order_item

  attributes :id, :order_id, :car_id, :service_id, :state, :paid, :price, :materials_price, :materials_comment,
             :delivery_price, :delivery_comment, :comment, :performer_fee, :updated_at, :created_at

  attribute :car do |order|
    [order.car.brand, order.car.model].compact.join(' ')
  end

  attribute :service do |order_item|
    order_item.service.title
  end

  many :order_item_performers, resource: OrderItemPerformerSerializer

  # one :performer, resource: lambda { |performer|
  #   case performer
  #   when User
  #     UserSerializer
  #   when Contractor
  #     ContractorSerializer
  #   end
  # }
end
