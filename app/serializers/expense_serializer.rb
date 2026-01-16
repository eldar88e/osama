class ExpenseSerializer
  include Alba::Resource

  root_key :expense

  attributes :id, :amount, :category_id, :description, :spent_at, :created_at
end
