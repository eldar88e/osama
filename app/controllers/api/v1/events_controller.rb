module Api
  module V1
    class EventsController < Api::V1::ApplicationController
      include Api::ResourceConcern

      before_action :set_date_range, only: :index

      def index
        query     = policy_scope(Event).order(:starts_at).ransack(params[:q])
        resources = query.result
        meta      = { start_at: params[:q][:starts_at_gteq], end_at: params[:q][:starts_at_lt] }

        render json: { data: EventSerializer.new(resources), meta: meta }
      end

      private

      def set_date_range
        params[:q] ||= {}
        params[:q][:starts_at_gteq] ||= Time.current.beginning_of_month
        params[:q][:starts_at_lt] ||= Time.current.end_of_month + 1.second
      end

      def event_params
        params.expect(event: %i[eventable_id eventable_type starts_at ends_at title kind])
      end
    end
  end
end
