class CreateCars < ActiveRecord::Migration[8.1]
  def change
    create_table :cars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :license_plate
      t.string :brand
      t.string :model
      t.string :vin
      t.text :comment

      t.timestamps
    end
  end
end
