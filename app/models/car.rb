class Car < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  validates :year,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1900,
              less_than_or_equal_to: Time.current.year + 1
            }
end
