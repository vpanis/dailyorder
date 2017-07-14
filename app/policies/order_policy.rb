class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.select { |record| record.relation.restaurant.users.include?(user) }
      end
    end
  end

  def index_pending?
    true
  end

  def index_validated?
    true
  end

  def index_sent?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end
end
