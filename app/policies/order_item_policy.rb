class OrderItemPolicy < ApplicationPolicy
  def index?
    admin_or_manager_or_staff? || record.order.user == user
  end

  def show?
    admin_or_manager_or_staff? || record.order.user == user
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
