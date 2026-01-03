class CarSerializer
  include Alba::Resource

  root_key :car

  attributes :id, :user_id, :license_plate, :brand, :model, :vin, :year, :comment
end
