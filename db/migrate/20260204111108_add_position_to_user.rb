class AddPositionToUser < ActiveRecord::Migration[8.1]
  def change
    # add_reference :users, :position, null: false, foreign_key: true

    add_reference :users, :position, foreign_key: true, null: true

    if User.exists?
      Position.create!(title: 'Другое') unless Position.exists?
      User.update_all(position_id: Position.first.id)
    end

    change_column_null :users, :position_id, false
  end
end
