class OrderItemPerformerSerializer
  include Alba::Resource

  root_key :order_item_performer

  attributes :id, :order_item_id, :performer_fee

  attribute :performer do |order_item_performer|
    case order_item_performer.performer
    when User
      UserSerializer
    when Contractor
      ContractorSerializer
    end
  end
end
