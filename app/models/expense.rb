class Expense < ApplicationRecord
  belongs_to :expense_category

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :spent_at, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id amount expense_category_id description spent_at created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
