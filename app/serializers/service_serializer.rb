class ServiceSerializer
  include Alba::Resource

  root_key :service

  attributes :id, :title
end
