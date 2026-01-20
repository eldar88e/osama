module Api
  module V1
    class MessagesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def message_params
        params.expect(message: %i[conversation_id direction external_id text payload])
      end
    end
  end
end
