class CreateExpenseCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :expense_categories do |t|
      t.string :title, null: false
      t.string :description
      t.integer :position, null: false, default: 0
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :expense_categories, :title, unique: true
    add_index :expense_categories, :active
  end
end
