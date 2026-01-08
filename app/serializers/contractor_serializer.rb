class ContractorSerializer
  include Alba::Resource

  root_key :contractor

  attributes :id, :name, :entity_type, :email, :phone, :inn, :kpp, :legal_address, :contact_person, :bank_name,
             :bik, :checking_account, :correspondent_account, :service_profile, :active, :comment, :created_at
end
