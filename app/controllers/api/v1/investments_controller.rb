module Api
  module V1
    class InvestmentsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def investment_params
        params.expect(investment: %i[amount comment invested_at user_id])
      end
    end
  end
end
