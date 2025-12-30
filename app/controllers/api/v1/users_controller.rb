module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def index
        q_collection = User.order(:created_at).ransack(params[:q])
        pagy, users  = pagy(q_collection.result)

        render json: { users: UserSerializer.new(users), meta: pagy_metadata(pagy) }
      end

      def show
        render json: UserSerializer.new(@resource)
      end

      def update
        if @resource.update(user_params)
          render json: UserSerializer.new(@resource)
        else
          render json: { errors: @resource.errors.full_messages }, status: :unprocessable_content
        end
      end

      def destroy
        @resource.destroy!
        head :no_content
      end

      private

      def set_user
        @resource = User.find(params[:id])
      end

      def user_params
        params.expect(user: %i[email first_name middle_name last_name phone additional_phone company_name inn kpp ogrn
                               legal_address actual_address contact_person contact_phone bank_name bik checking_account
                               correspondent_account source comment active])
      end
    end
  end
end
