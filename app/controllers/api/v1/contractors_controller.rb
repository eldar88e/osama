module Api
  module V1
    class ContractorsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def contractor_params
        params.expect(contractor: %i[name entity_type email phone inn kpp legal_address contact_person bank_name
                                     bik checking_account correspondent_account service_profile active comment])
      end
    end
  end
end
