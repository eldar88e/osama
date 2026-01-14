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
        transitions from: %i[initial completed], to: :processing

        after { set_processing_at }
      end

      event :complete do
        transitions from: :processing, to: :completed,
                    guard: %i[all_items_paid? all_items_completed? price?]

        after { set_completed_at }
      end

      event :cancel do
        transitions from: %i[initial processing completed], to: :cancelled

        after { set_cancelled_at }
      end
    end
  end

  private

  def set_processing_at
    update_column(:processing_at, Time.current) unless processing_at
  end

  def set_completed_at
    update_column(:completed_at, Time.current) unless completed_at
  end

  def set_cancelled_at
    update_column(:cancelled_at, Time.current) unless cancelled_at
  end
end
