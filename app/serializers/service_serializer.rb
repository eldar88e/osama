class CarSerializer
  include Alba::Resource

  root_key :car

  attributes :id, :title
end
