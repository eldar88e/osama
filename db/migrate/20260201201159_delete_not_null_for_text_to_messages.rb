class DeleteNotNullForTextToMessages < ActiveRecord::Migration[8.1]
  def change
    change_column_null :messages, :text, true
  end
end
