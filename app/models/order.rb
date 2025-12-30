class Order < ApplicationRecord
  include AASM

  aasm column: :state do
    state :initial, initial: true
    state :processing
    state :completed
    state :cancelled

    event :process do
      transitions from: :initial, to: :processing
    end

    event :complete do
      transitions from: :processing, to: :completed, guard: %i[all_items_paid? price?]
    end

    event :cancel do
      transitions from: %i[initial processing], to: :cancelled
    end
  end

  belongs_to :user
  belongs_to :car

  has_many :order_items, dependent: :destroy

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :expense, numericality: { greater_than_or_equal_to: 0 }
  validates :appointment_at, presence: true

  def recalc_totals!
    self.price   = order_items.sum(:price)
    self.expense =
      order_items.sum(:materials_price) +
      order_items.sum(:delivery_price)
    save!
  end

  def all_items_paid?
    order_items.exists? && order_items.where(paid: false).none?
  end

  def sync_paid!
    self.paid = all_items_paid?
    recalc_totals!
  end

  def price?
    price.positive?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id state paid]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
