class AddUniqueIndexToPositionsTitle < ActiveRecord::Migration[8.1]
  def change
    add_index :positions, :title, unique: true
  end
end
