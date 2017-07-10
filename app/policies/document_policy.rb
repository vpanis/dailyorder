class DocumentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.order.relation.restaurant.users.include?(user) || user.admin
  end

  def create?
    record.order.relation.restaurant.users.include?(user) || user.admin
  end
end
