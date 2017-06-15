class PricingCondition < ApplicationRecord
    belongs_to :relation
    belongs_to :product

    validates :price, presence: true
end
