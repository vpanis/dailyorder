class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    record.relation.restaurant.users.include?(user) || user.admin
  end

  def new?
    record.relation.restaurant.users.include?(user) || user.admin
  end

  def create?
    record.relation.restaurant.users.include?(user) || user.admin
  end

  def update?
    record.relation.restaurant.users.include?(user) || user.admin
  end

  def destroy?
    record.relation.restaurant.users.include?(user) || user.admin
  end
end
