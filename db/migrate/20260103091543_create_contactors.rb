class CreateContactors < ActiveRecord::Migration[8.1]
  def change
    create_table :contactors do |t|
      t.string :name, null: false
      t.integer :entity_type, null: false
      t.string :inn
      t.string :kpp
      t.string :legal_address
      t.string :contact_person
      t.string :phone
      t.string :email
      t.string :bank_name
      t.string :bik
      t.string :checking_account
      t.string :correspondent_account
      t.text :service_profile
      t.text :comment
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :contactors, :name
    add_index :contactors, :phone
    add_index :contactors, :active
  end
end
