class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.string :state, null: false, default: 'initial'
      t.decimal :price,   precision: 12, scale: 2, null: false, default: 0
      t.decimal :expense, precision: 12, scale: 2, null: false, default: 0
      t.boolean :paid, null: false, default: false
      t.string :comment
      t.datetime :appointment_at
      t.datetime :processing_at
      t.datetime :completed_at
      t.datetime :cancelled_at

      t.timestamps
    end

    add_index :orders, :state
    add_index :orders, :paid
  end
end
