class EventPolicy < ApplicationPolicy

  def new?
    user and user.profile.admin?
  end
end