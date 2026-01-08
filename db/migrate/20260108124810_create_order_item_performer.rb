class CreateOrderItemPerformer < ActiveRecord::Migration[8.1]
  def change
    create_table :order_item_performers do |t|
      t.references :order_item, null: false, foreign_key: true

      t.references :performer, polymorphic: true, null: false

      t.decimal :performer_fee, precision: 12, scale: 2, null: false

      t.integer :role, null: false, default: 0

      t.timestamps
    end

    add_index :order_item_performers, [:order_item_id, :performer_type, :performer_id], unique: true
  end
end
