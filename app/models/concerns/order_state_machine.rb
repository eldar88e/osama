module OrderStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :state do
      state :initial, initial: true
      state :processing
      state :completed
      state :cancelled

      event :process do
        transitions from: :initial, to: :processing

        after { update!(processing_at: Time.current) }
      end

      event :complete do
        transitions from: :processing, to: :completed,
                    guard: %i[all_items_paid? price?]

        after { update!(completed_at: Time.current) }
      end

      event :cancel do
        transitions from: %i[initial processing], to: :cancelled

        after { update!(cancelled_at: Time.current) }
      end
    end
  end
end
