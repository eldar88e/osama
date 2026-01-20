class Conversation < ApplicationRecord
  belongs_to :user, optional: true

  has_many :messages, dependent: :destroy

  validates :external_id, presence: true
  validates :source, uniqueness: { scope: :external_id }

  enum :source, { whatsapp: 0, telegram: 1 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id source]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
