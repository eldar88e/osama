class Expense < ApplicationRecord
  enum :category, {
    other: 0,
    equipment: 1,
    service: 2,
    materials: 3,
    marketing: 4,
    software: 5,
    site: 6
  }

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :spent_at, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id amount category description spent_at created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
