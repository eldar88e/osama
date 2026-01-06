class AddPerformerFeeToOrderItems < ActiveRecord::Migration[8.1]
  def change
    add_column :order_items,  :performer_fee, :decimal, precision: 10, scale: 2, default: 0, null: false
  end
end
