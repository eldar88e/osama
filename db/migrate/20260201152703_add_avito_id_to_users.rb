class AddAvitoIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :avito_id, :string
    add_index :users, :avito_id, unique: true
  end
end
