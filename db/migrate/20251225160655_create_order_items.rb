class CreateOrderItems < ActiveRecord::Migration[8.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :performer, polymorphic: true, null: false
      t.string :state, null: false, default: 'initial'
      t.decimal :materials_price, precision: 12, scale: 2, null: false, default: 0
      t.string :materials_comment
      t.decimal :delivery_price, precision: 12, scale: 2, null: false, default: 0
      t.string :delivery_comment
      t.decimal :price, precision: 12, scale: 2, null: false, default: 0
      t.boolean :paid, null: false, default: false
      t.string :comment

      t.timestamps
    end

    add_index :order_items, :state
    add_index :order_items, :paid
  end
end
