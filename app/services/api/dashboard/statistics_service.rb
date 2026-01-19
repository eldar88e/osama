# frozen_string_literal: true

module Api
  module Dashboard
    class StatisticsService
      WAITING_STATES = %w[
        initial
        diagnostic
        agreement
      ].freeze

      IN_WORK_STATES = %w[
        processing
        control
      ].freeze

      def call
        {
          cars_waiting: cars_waiting,
          cars_in_work: cars_in_work,
          money_in_work: money_in_work,
          new_orders_week: new_orders_week
        }
      end

      private

      def cars_waiting
        OrderItem
          .where(state: WAITING_STATES)
          .distinct
          .count(:car_id)
      end

      def cars_in_work
        OrderItem
          .where(state: IN_WORK_STATES)
          .distinct
          .count(:car_id)
      end

      def money_in_work
        OrderItem
          .where(paid: false)
          .sum(
            <<~SQL.squish
              price +
              materials_price +
              delivery_price +
              performer_fee
            SQL
          )
      end

      def new_orders_week
        Order
          .where(created_at: 1.week.ago..Time.current)
          .count
      end
    end
  end
end
