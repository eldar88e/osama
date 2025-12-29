class UserSerializer
  include Alba::Resource

  # attributes :id, :email

  root_key :user

  attributes :id, :email, :full_name, :phone, :additional_phone, :company_name, :inn, :kpp, :ogrn, :legal_address, :actual_address, :contact_person, :contact_phone, :bank_name, :bik, :checking_account, :correspondent_account, :source, :comment, :active, :role, :created_at

  # attribute :name_with_email do |resource|
  #   "#{resource.email}: #{resource.email}"
  # end
end
