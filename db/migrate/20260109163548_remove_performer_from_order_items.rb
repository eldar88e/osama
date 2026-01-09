class RemovePerformerFromOrderItems < ActiveRecord::Migration[8.1]
  def change
    remove_column :order_items, :performer_type, :string
    remove_column :order_items, :performer_id, :string
  end
end
