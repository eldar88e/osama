class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :additional_phone, :string
    add_column :users, :company_name, :string
    add_column :users, :inn, :string
    add_column :users, :kpp, :string
    add_column :users, :ogrn, :string
    add_column :users, :legal_address, :string
    add_column :users, :actual_address, :string
    add_column :users, :contact_person, :string
    add_column :users, :contact_phone, :string
    add_column :users, :bank_name, :string
    add_column :users, :bik, :string
    add_column :users, :checking_account, :string
    add_column :users, :correspondent_account, :string
    add_column :users, :source, :string
    add_column :users, :comment, :text
    add_column :users, :active, :boolean, default: true, null: false
  end
end
