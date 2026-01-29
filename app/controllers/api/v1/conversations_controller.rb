module Api
  module V1
    class ConversationsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      def index
        q = policy_scope(resource_class).order(last_message_at: :desc).ransack(params[:q])

        pagy, resources = pagy(q.result)

        render json: { data: serializer.new(resources), meta: pagy_metadata(pagy) }
      end

      private

      def conversation_params
        params.expect(conversation: %i[external_id source user_id])
      end
    end
  end
end
