class OrderItemPerformerSerializer
  include Alba::Resource

  root_key :order_item_performer

  attributes :id, :order_item_id, :performer_id, :performer_type, :performer_fee

  attribute :performer_name do |order_item_performer|
    performer = order_item_performer.performer

    case performer
    when User
      performer.full_name
    when Contractor
      performer.name
    end
  end
end
