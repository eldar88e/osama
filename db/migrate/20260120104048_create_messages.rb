class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.integer :direction, null: false
      t.string :external_id, null: false
      t.text :text, null: false
      t.jsonb :payload, null: false, default: {}

      t.timestamps
    end

    add_index :messages, [:conversation_id, :external_id], unique: true
    add_index :messages, :created_at
  end
end
