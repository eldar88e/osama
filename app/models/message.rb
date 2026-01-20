class Message < ApplicationRecord
  belongs_to :conversation

  enum :direction, { incoming: 0, outgoing: 1 }

  before_validation :strip_text, if: -> { outgoing? && text.present? }

  validates :direction, presence: true
  validates :text, presence: true
  validates :conversation_id, uniqueness: { scope: :external_id }

  def strip_text
    self.text = text.strip
  end
end
