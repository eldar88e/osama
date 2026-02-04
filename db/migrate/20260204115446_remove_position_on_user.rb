class RemovePositionOnUser < ActiveRecord::Migration[8.1]
  def change
    remove_reference :users, :position, foreign_key: true
  end
end
