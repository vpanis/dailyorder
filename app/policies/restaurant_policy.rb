class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    record.users.include?(user) || user.admin
  end

  def show?
    record.users.include?(user) || user.admin
  end

  def new?
    true
  end

  def create?
    record.users.include?(user) || user.admin
  end

  def edit?
    record.users.include?(user) && Profile.where(user: user, restaurant: record).first.role == "Administrateur" || user.admin
  end

  def update?
    record.users.include?(user) && Profile.where(user: user, restaurant: record).first.role == "Administrateur" || user.admin
  end

  def destroy?
    record.users.include?(user) && Profile.where(user: user, restaurant: record).first.role == "Administrateur" || user.admin
  end
end
