class AddExpiresAtToApiSessions < ActiveRecord::Migration[8.1]
  def change
    add_column :api_sessions, :expires_at, :datetime, null: false
    add_index :api_sessions, :expires_at
  end
end
