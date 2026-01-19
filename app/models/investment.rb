class Investment < ApplicationRecord
  belongs_to :user, optional: true

  validates :amount, numericality: { greater_than: 0 }
  validates :invested_at, presence: true

  # scope :recent, -> { order(invested_at: :desc) }
  # scope :for_period, ->(from, to) { where(invested_at: from..to) }
end
