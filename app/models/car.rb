class Car < ApplicationRecord
  belongs_to :client, class_name: 'User', foreign_key: :user_id, inverse_of: :cars
end
