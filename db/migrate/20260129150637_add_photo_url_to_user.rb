class AddPhotoUrlToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :photo_url, :string
  end
end
