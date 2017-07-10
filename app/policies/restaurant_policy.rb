class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.group == record.group || user.admin
  end

  def new?
    user.group == record.group || user.admin
  end

  def create?
    user.group == record.group || user.admin
  end

end
