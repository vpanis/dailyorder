class DeliveryConditionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    record.relation.supplier.users.include?(user) || user.admin
  end

  def create?
    record.relation.supplier.users.include?(user) || user.admin
  end

  def edit?
    record.relation.supplier.users.include?(user) || user.admin
  end

  def update?
    record.relation.supplier.users.include?(user) || user.admin
  end
end
