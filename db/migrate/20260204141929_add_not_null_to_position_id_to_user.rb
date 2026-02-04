class AddNotNullToPositionIdToUser < ActiveRecord::Migration[8.1]
  def change
    change_column_null :users, :position_id, false
  end
end
