module Api
  module V1
    class ExpenseCategoriesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def expense_category_params
        params.expect(expense_category: %i[title description position active])
      end
    end
  end
end
