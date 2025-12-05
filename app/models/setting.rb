class Setting < ApplicationRecord
  validates :variable, presence: true, uniqueness: true

  after_commit :clear_settings_cache, on: %i[create update destroy]

  def self.all_cached
    Rails.cache.fetch(:settings) { pluck(:variable, :value).to_h.symbolize_keys }
  end

  def self.fetch_value(key)
    all_cached[key]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id variable]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end

  private

  def clear_settings_cache
    Rails.cache.delete_multi(%i[settings])
  end
end
