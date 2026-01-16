class ExpenseSerializer
  include Alba::Resource

  root_key :expense

  attributes :id, :amount, :expense_category_id, :description, :spent_at, :created_at
end
