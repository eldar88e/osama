class MessagePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    false
  end

  def create?
    true
  end

  def update?
    admin_or_manager_or_staff? || record.conversation.user == user
  end

  def destroy?
    admin?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.manager? || user.staff?
        scope.all
      else
        scope.where(conversation: { user_id: user.id })
      end
    end
  end
end
