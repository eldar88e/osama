module Api
  module V1
    class ConversationsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def conversation_params
        params.expect(conversation: %i[external_id source user_id])
      end
    end
  end
end
