class ExpenseCategorySerializer
  include Alba::Resource

  root_key :expense_category

  attributes :id, :title, :description, :position, :active, :created_at
end
