class AddExpenseCategoryToExpenses < ActiveRecord::Migration[8.1]
  def change
    add_reference :expenses, :expense_category, null: false, foreign_key: true
  end
end
