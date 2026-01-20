module Api
  module V1
    class MessagesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      MESSAGES_PER_PAGE = 100

      def index
        q = policy_scope(resource_class).joins(:conversation)
                                        .where(conversations: { id: params[:conversation_id] })
                                        .order(created_at: :desc).ransack(params[:q])

        pagy, resources = pagy(q.result, items: MESSAGES_PER_PAGE)

        render json: { data: serializer.new(resources), meta: pagy_metadata(pagy) }
      end

      private

      def message_params
        params.expect(message: %i[text])
      end
    end
  end
end
