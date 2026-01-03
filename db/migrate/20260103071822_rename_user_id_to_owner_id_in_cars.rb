class RenameUserIdToOwnerIdInCars < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :cars, :users
    rename_column :cars, :user_id, :owner_id
    add_foreign_key :cars, :users, column: :owner_id
  end
end
