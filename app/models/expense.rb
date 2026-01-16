class Expense < ApplicationRecord
  belongs_to :category, class_name: 'ExpenseCategory', foreign_key: :expense_category_id, inverse_of: :expenses

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :spent_at, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id amount category description spent_at created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
