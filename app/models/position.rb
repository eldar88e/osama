class Position < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :title, presence: true, uniqueness: true
end
