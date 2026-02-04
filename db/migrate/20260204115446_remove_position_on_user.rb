class RemovePositionOnUser < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :position, foreign_key: true
  end
end
