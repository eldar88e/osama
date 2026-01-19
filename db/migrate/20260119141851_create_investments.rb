class CreateInvestments < ActiveRecord::Migration[8.1]
  def change
    create_table :investments do |t|
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :comment
      t.datetime :invested_at, null: false

      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :investments, :invested_at
  end
end
