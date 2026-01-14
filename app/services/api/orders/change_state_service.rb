module Api
  module Orders
    class ChangeStateService
      def initialize(order, new_state)
        @new_state = new_state
        @order = order
      end

      def self.call(order, new_state)
        return if order.state == new_state

        case new_state
        when 'processing'
          order.process!
        when 'completed'
          order.complete!
        when 'cancelled'
          order.cancel!
        end
      end
    end
  end
end
