class EventSerializer
  include Alba::Resource

  root_key :event

  attributes :id, :eventable_id, :eventable_type, :starts_at, :ends_at, :title, :kind
end
