module Admin
  class UsersController < ApplicationController
    BASE_PARAMS = %i[email first_name middle_name last_name phone additional_phone company_name inn kpp ogrn
                     legal_address actual_address contact_person contact_phone bank_name bik checking_account
                     correspondent_account source comment active role].freeze

    include ResourceConcerns

    private

    def user_params
      params.expect(user: [*BASE_PARAMS])
    end
  end
end
