class OrderItem < ApplicationRecord
  include AASM

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :materials_price, numericality: { greater_than_or_equal_to: 0 }
  validates :delivery_price, numericality: { greater_than_or_equal_to: 0 }
  validates :performer_fee, numericality: { greater_than_or_equal_to: 0 }

  # rubocop:disable Metrics/BlockLength
  aasm column: :state do
    state :initial, initial: true
    state :diagnostic
    state :agreement
    state :processing
    state :control
    state :completed
    state :cancelled

    event :start_diagnostic do
      transitions from: :initial, to: :diagnostic
    end

    event :agree do
      transitions from: :diagnostic, to: :agreement
    end

    event :start_processing do
      transitions from: :agreement, to: :processing
    end

    event :send_to_control do
      transitions from: :processing, to: :control
    end

    event :complete do
      transitions from: :control, to: :completed
    end

    event :cancel do
      transitions from: %i[
        initial
        diagnostic
        agreement
        processing
        control
      ], to: :cancelled
    end
  end
  # rubocop:enable Metrics/BlockLength

  belongs_to :order
  belongs_to :service
  # belongs_to :performer, polymorphic: true

  has_many :order_item_performers, dependent: :destroy, inverse_of: :order_item
  has_many :staffs, through: :order_item_performers, source: :performer, source_type: 'User'
  has_many :contractors, through: :order_item_performers, source: :performer, source_type: 'Contractor'

  accepts_nested_attributes_for :order_item_performers, allow_destroy: true

  after_commit :sync_order_if_needed

  private

  def sync_order_if_needed
    return unless
      saved_change_to_paid? ||
      saved_change_to_price? ||
      saved_change_to_materials_price? ||
      saved_change_to_delivery_price? ||
      saved_change_to_performer_fee?

    order.sync_paid!
  end
end
