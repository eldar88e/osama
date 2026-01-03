class AddYearToCars < ActiveRecord::Migration[8.1]
  def change
    add_column :cars, :year, :integer
  end
end
