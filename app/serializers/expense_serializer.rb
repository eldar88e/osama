class ExpenseSerializer
  include Alba::Resource

  root_key :expense

  attributes :id, :amount, :description, :spent_at, :expense_category_id, :created_at

  attribute :category do |expense|
    expense.expense_category&.title
  end
end
