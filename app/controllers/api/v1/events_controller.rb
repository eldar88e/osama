module Api
  module V1
    class EventsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      private

      def event_params
        params.expect(event: %i[eventable_id eventable_type starts_at ends_at title kind])
      end
    end
  end
end
