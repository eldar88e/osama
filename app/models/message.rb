class Message < ApplicationRecord
  belongs_to :conversation

  enum :direction, { incoming: 0, outgoing: 1 }
  enum :msg_type, { text: 0, image: 1, video: 2, audio: 3, file: 4, sticker: 5, location: 6, contact: 7 }

  before_validation :strip_text, on: :create, if: -> { outgoing? && text.present? }
  before_validation :set_direction, on: :create, if: -> { direction.blank? }

  validates :direction, presence: true
  validates :conversation_id, uniqueness: { scope: :external_id }

  after_create_commit :update_conversation_last_message_at
  after_create_commit :broadcast_widget_chat, if: -> { incoming? }

  def strip_text
    self.text = text.strip
  end

  def set_direction
    self.direction = :outgoing
  end

  private

  # rubocop:disable Rails/SkipsModelValidations
  def update_conversation_last_message_at
    Rails.logger.warn "Update conversation last message at: #{created_at}"
    conversation.update_column(:last_message_at, created_at)
  end
  # rubocop:enable Rails/SkipsModelValidations

  def broadcast_widget_chat
    CableBroadcastJob.perform_later(
      "conversation_#{conversation_id}",
      MessageSerializer.new(self).as_json
    )
  end
end
