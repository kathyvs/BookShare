class EventPolicy < ApplicationPolicy

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def admin?
    user and user.admin?
  end
end