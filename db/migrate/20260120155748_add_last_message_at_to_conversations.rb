class AddLastMessageAtToConversations < ActiveRecord::Migration[8.1]
  def change
    add_column :conversations, :last_message_at, :datetime
    add_index  :conversations, :last_message_at
  end
end
