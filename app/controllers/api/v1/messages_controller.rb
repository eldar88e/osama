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

        render json: { data: serializer.new(resources.reverse), meta: pagy_metadata(pagy) }
      end

      def create
        external_id = Telegram::SenderService.call(params[:message][:text])
        return render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity unless external_id.is_a?(Integer)

        resource = resource_class.new(message_params[:message])
        resource.conversation = Conversation.find(params[:conversation_id])
        authorize resource

        if resource.save
          render json: { data: serializer.new(resource) }, status: :created
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def message_params
        params.expect(message: %i[text])
      end
    end
  end
end
