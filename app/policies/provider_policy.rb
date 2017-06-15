class ProviderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
