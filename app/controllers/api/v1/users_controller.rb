module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def user_params
        # TODO: add password for create
        params.expect(user: %i[email first_name middle_name last_name phone additional_phone company_name inn kpp ogrn
                               legal_address actual_address contact_person contact_phone bank_name bik checking_account
                               correspondent_account source comment active])
      end
    end
  end
end
