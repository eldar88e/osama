class AddPublishedAtToMessage < ActiveRecord::Migration[8.1]
  def change
    add_column :messages, :published_at, :datetime
  end
end
