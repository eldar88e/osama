class Service < ApplicationRecord
  validates :title, presence: true
  # validates :slug, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  enum :category, {
    dry_cleaning: 0,      # Химчистка
    upholstery: 1,        # Перетяжка салона / элементов
    soundproofing: 2      # Шумоизоляция авто
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id title price category active]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
