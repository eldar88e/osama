class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable

  enum :role, { user: 0, staff: 1, manager: 2, admin: 3 }

  has_many :cars, inverse_of: :client

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def manager?
    role == 'manager'
  end

  def admin_or_moderator_or_manager?
    moderator? || admin? || manager?
  end

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email role]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[]
  end
end
