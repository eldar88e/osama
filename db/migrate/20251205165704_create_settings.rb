class CreateSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :settings do |t|
      t.string :variable
      t.string :value

      t.timestamps
    end

    add_index :settings, :variable, unique: true
  end
end
