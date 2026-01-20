class CreateConversations < ActiveRecord::Migration[8.1]
  def change
    create_table :conversations do |t|
      t.integer :source, null: false
      t.string :external_id, null: false
      t.jsonb :meta, null: false, default: {}
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end

    add_index :conversations, [:source, :external_id], unique: true
  end
end
