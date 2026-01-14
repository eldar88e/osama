class Event < ApplicationRecord
  belongs_to :eventable, polymorphic: true, optional: true

  enum :kind, { primary: 0, success: 1, warning: 2, danger: 3 }

  validates :title, presence: true
  validates :starts_at, presence: true
end
