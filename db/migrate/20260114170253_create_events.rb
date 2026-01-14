class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.references :eventable, polymorphic: true
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.string :title, null: false
      t.integer :kind, default: 0, null: false

      t.timestamps
    end
  end
end
