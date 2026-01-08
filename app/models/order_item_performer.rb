class OrderItemPerformer < ApplicationRecord
  belongs_to :order_item
  belongs_to :performer, polymorphic: true

  enum :role, { main: 0, assistant: 1 }

  validates :performer_fee, numericality: { greater_than_or_equal_to: 0 }
end
