class Car < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  validates :brand, presence: true
  validates :model, presence: true
  validates :year,
            numericality: {
              greater_than_or_equal_to: 1960,
              less_than_or_equal_to: Time.current.year
            }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id owner_id brand model license_plate]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
