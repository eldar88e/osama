class RenameUserIdToClientIdInOrders < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :orders, :users
    rename_column :orders, :user_id, :client_id
    add_foreign_key :orders, :users, column: :client_id
  end
end
