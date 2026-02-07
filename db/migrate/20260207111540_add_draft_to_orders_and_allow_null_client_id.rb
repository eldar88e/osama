class AddDraftToOrdersAndAllowNullClientId < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :draft, :boolean, default: true, null: false
    add_index :orders, :draft

    change_column_null :orders, :client_id, true
  end
end
