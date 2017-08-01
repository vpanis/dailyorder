class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    !user.suppliers.first.nil?
  end

  def import?
    !user.suppliers.first.nil?
  end
end
