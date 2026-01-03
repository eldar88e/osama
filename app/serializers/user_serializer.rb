class UserSerializer
  include Alba::Resource

  root_key :user

  attributes :id, :email, :first_name, :middle_name, :last_name, :full_name, :phone, :additional_phone,
             :company_name, :inn, :kpp, :ogrn, :legal_address, :actual_address, :contact_person, :contact_phone,
             :bank_name, :bik, :checking_account, :correspondent_account, :source, :comment, :active,
             :role, :position, :created_at
end
