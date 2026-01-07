class Contactor < ApplicationRecord
  enum :entity_type, { individual: 0, legal: 1 }

  validates :name, presence: true
  validates :entity_type, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :inn, length: { in: 10..12 }, allow_blank: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name entity_type phone]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
