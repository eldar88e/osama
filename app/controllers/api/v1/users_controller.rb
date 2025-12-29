module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      def index
        q_collection = User.order(:created_at).ransack(params[:q])
        pagy, users = pagy(q_collection.result)

        render json: { users: UserSerializer.new(users), meta: pagy_metadata(pagy) }
      end
    end
  end
end
