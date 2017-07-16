class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.restaurants.include?(record.restaurant) || user.admin
  end

  def new?
    user.restaurants.include?(record.restaurant) || user.admin
  end

  def create?
    user.restaurants.include?(record.restaurant) || user.admin
  end

  def edit?
    user.restaurants.include?(record.restaurant) || user.admin
  end

  def update?
    user.restaurants.include?(record.restaurant) || user.admin
  end
end
