class ConversationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin_or_manager_or_staff? || record.user == user
  end

  def create?
    true
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.manager? || user.staff?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
