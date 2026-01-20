module Api
  module V1
    class MessagesController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def message_params
        params.expect(message: %i[text])
      end
    end
  end
end
