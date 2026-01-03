class ContactorPolicy < ApplicationPolicy
  def index?
    admin_or_manager_or_staff?
  end

  def show?
    admin_or_manager_or_staff?
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

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
