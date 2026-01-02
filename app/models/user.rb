class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable

  enum :role, { user: 0, staff: 1, manager: 2, admin: 3 }

  has_many :cars, inverse_of: :client, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :api_sessions, dependent: :destroy

  before_validation :set_default_attributes, if: :new_record?

  def admin_or_manager_or_staff?
    admin? || manager? || staff?
  end

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  ransacker :full_name do
    Arel.sql(
      "concat_ws(' ', middle_name, first_name, last_name)"
    )
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email role full_name phone]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end

  def set_default_attributes
    self.email = "user_#{User.last.id + 1}@#{ENV.fetch('EMAIL_HOST', ENV.fetch('HOST'))}" if email.blank?
    self.password = Devise.friendly_token.first(8)
  end
end
