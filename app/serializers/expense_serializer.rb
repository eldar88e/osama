class ExpenseSerializer
  include Alba::Resource

  root_key :expense

  attributes :id, :amount, :description, :spent_at, :created_at

  attribute :category_title do |expense|
    expense.category&.title
  end
end
