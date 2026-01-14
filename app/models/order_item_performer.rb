class OrderItemPerformer < ApplicationRecord
  belongs_to :order_item
  belongs_to :performer, polymorphic: true

  enum :role, { main: 0, assistant: 1 }

  validates :performer_fee, numericality: { greater_than_or_equal_to: 0 }

  after_commit :sync_order_item_if_needed

  private

  def sync_order_item_if_needed
    return unless saved_change_to_performer_fee?

    order_item.sync_performer_fee!
  end
end
