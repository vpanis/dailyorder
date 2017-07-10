class OrderLinePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    record.order.relation.restaurant.users.include?(user) || user.admin
  end

  def create?
    record.order.relation.restaurant.users.include?(user) || user.admin
  end

  def update?
    record.order.relation.restaurant.users.include?(user) || user.admin
  end
end
