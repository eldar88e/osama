class Order < ApplicationRecord
  ITEM_STATES_FOR_COMPLETED = %i[completed cancelled].freeze

  include OrderStateMachine

  belongs_to :client, class_name: 'User', optional: true

  has_many :order_items, dependent: :destroy
  has_one :event, as: :eventable, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :expense, numericality: { greater_than_or_equal_to: 0 }
  validates :appointment_at, presence: true, unless: :draft?
  validates :client_id, presence: true, unless: :draft?

  before_validation {self.paid_at = Time.current if paid? && paid_at.blank? }
  # after_create :create_event!
  after_update :update_event!, unless: :draft?

  scope :drafts, -> { where(draft: true) }
  scope :published, -> { where(draft: false) }

  def all_items_paid?
    order_items.exists? && order_items.where(paid: false).none?
  end

  def all_items_completed?
    order_items.exists? && order_items.where.not(state: ITEM_STATES_FOR_COMPLETED).none?
  end

  def sync_paid!
    self.paid    = all_items_paid?
    self.price   = order_items.sum(:price)
    self.expense =
      order_items.sum(:materials_price) +
      order_items.sum(:delivery_price) +
      order_items.sum(:performer_fee)
    save!
  end

  def price?
    price.positive?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id state paid price appointment_at processing_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end

  private

  def create_event!
    Event.create!(eventable: self, starts_at: appointment_at, title: 'Запись', kind: :primary)
  end

  def update_event!
    # event.update!(starts_at: appointment_at) if previous_changes['appointment_at'].present?

    current_event = Event.find_or_create_by!(eventable: self) do |event|
      event.starts_at = appointment_at
      event.title = 'Запись'
      event.kind = :primary
    end

    current_event.update!(starts_at: appointment_at)
  end
end
