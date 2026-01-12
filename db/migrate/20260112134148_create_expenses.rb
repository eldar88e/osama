class CreateExpenses < ActiveRecord::Migration[8.1]
  def change
    create_table :expenses do |t|
      t.decimal :amount, default: 0, null: false
      t.integer :category, default: 0, null: false
      t.string :description
      t.datetime :spent_at, null: false

      t.timestamps
    end
  end
end
