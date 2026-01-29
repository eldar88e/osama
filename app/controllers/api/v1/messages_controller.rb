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
        resource = resource_class.new(message_params)
        Rails.logger.warn params
        Rails.logger.warn message_params
        Rails.logger.warn resource
        conversation = Conversation.find(message_params[:conversation_id])
        external_id = Telegram::SenderService.call(params[:message][:text], conversation.external_id)
        return render json: { errors: external_id&.messages }, status: :unprocessable_entity unless external_id.is_a?(Integer)

        resource.external_id = external_id.to_s
        authorize resource

        if resource.save
          render json: { data: serializer.new(resource) }, status: :created
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def message_params
        params.expect(message: %i[text conversation_id])
      end
    end
  end
end
