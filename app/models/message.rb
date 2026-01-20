class Message < ApplicationRecord
  belongs_to :conversation

  enum :direction, { incoming: 0, outgoing: 1 }

  before_validation :strip_text, on: :create, if: -> { outgoing? && text.present? }
  before_validation :set_direction, on: :create, if: -> { direction.blank? }

  validates :direction, presence: true
  validates :text, presence: true
  validates :conversation_id, uniqueness: { scope: :external_id }

  def strip_text
    self.text = text.strip
  end

  def set_direction
    self.direction = :outgoing
  end
end
