class AddDepositToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :deposit, :decimal, precision: 12, scale: 2, default: 0, null: false
    add_column :orders, :paid_at, :datetime, default: nil
    add_column :orders, :paid, :boolean, default: false, null: false
  end
end
