class ExpenseCategory < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :expenses, dependent: :restrict_with_error

  def self.ransackable_attributes(_auth_object = nil)
    %w[id title position active]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
