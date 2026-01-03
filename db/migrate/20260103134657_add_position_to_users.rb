class AddPositionToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :position, :integer, default: 0, null: false
  end
end
