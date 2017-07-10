class RelationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.restaurant.users.include?(user) || user.admin
  end
end
