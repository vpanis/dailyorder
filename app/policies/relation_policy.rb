class RelationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    record.restaurant.users.include?(user) || user.admin
  end

  def create?
    record.restaurant.users.include?(user) || user.admin
  end
end
