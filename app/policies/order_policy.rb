class OrderPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin_or_manager_or_staff? || record.client == user
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def statistics?
    admin?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.manager? || user.staff?
        scope.all
      else
        scope.where(client_id: user.id)
      end
    end
  end
end
