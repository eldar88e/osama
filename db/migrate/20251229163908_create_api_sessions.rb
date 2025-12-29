class CreateApiSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :api_sessions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :refresh_token_digest, null: false
      t.string :user_agent
      t.string :ip
      t.datetime :revoked_at

      t.timestamps
    end
    add_index :api_sessions, :refresh_token_digest, unique: true
    add_index :api_sessions, [:user_id, :revoked_at]
  end
end
