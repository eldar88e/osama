module Api
  module V1
    class MessagesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      before_action :set_messages, only: [:index]

      MESSAGES_PER_PAGE = 100

      def index
        pagy, resources = pagy(@q.result, items: MESSAGES_PER_PAGE)

        render json: { data: serializer.new(resources.reverse), meta: pagy_metadata(pagy) }
      end

      def create
        make_resource
        if @resource.save
          render json: { data: serializer.new(@resource) }, status: :created
        else
          render json: { errors: @resource.errors.full_messages }, status: :unprocessable_content
        end
      end

      private

      def set_messages
        @q = policy_scope(resource_class).joins(:conversation)
                                         .where(conversations: { id: params[:conversation_id] })
                                         .order(created_at: :desc).ransack(params[:q])
      end

      def message_params
        params.expect(message: %i[text conversation_id])
      end

      def make_resource
        @resource = resource_class.new(message_params)
        authorize @resource
        conversation = Conversation.find(message_params[:conversation_id])
        external_id  = send_to_service(conversation)
        if external_id.is_a?(Integer)
          @resource.external_id = external_id.to_s
        else
          render json: { errors: external_id&.messages }, status: :unprocessable_content
        end
      end

      def send_to_service(conversation)
        if conversation.source.to_sym == :telegram
          Telegram::SenderService.call(params[:message][:text], conversation.external_id)
        elsif conversation.source.to_sym == :avito
          Avito::SenderService.call(params[:message][:text], conversation.external_id)
        else
          # TODO: Implement other sources
          raise "Unsupported conversation source: #{conversation.source}"
        end
      end
    end
  end
end
