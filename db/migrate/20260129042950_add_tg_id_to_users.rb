class AddTgIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :tg_id, :string
    add_index :users, :tg_id, unique: true
  end
end
