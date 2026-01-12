class ExpenseSerializer
  include Alba::Resource

  root_key :expense

  attributes :id, :amount, :category, :description, :spent_at, :created_at
end
