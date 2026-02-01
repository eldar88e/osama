class AddDataAndMsgTypeToMessages < ActiveRecord::Migration[8.1]
  def change
    add_column :messages, :data, :jsonb, default: {}
    add_column :messages, :msg_type, :integer, default: 0
  end
end
