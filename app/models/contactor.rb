class Contactor < ApplicationRecord
  enum :entity_type, { individual: 0, legal: 1 }

  validates :name, presence: true
  validates :entity_type, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :inn, length: { in: 10..12 }, allow_blank: true
end
