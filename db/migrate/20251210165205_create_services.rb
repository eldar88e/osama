class CreateServices < ActiveRecord::Migration[8.1]
  def change
    create_table :services do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.integer :price, null: false, default: 0
      t.integer :duration_minutes
      t.integer :category, null: false, default: 0
      t.integer :popularity, null: false, default: 0
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :services, :slug, unique: true
    add_index :services, :category
    add_index :services, :active
  end
end
