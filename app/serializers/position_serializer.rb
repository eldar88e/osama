class PositionSerializer
  include Alba::Resource

  root_key :position

  attributes :id, :title
end
