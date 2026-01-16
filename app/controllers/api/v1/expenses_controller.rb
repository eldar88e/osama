module Api
  module V1
    class ExpensesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def expense_params
        params.expect(expense: %i[amount category_id description spent_at])
      end
    end
  end
end
