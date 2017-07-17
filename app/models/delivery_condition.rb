class DeliveryCondition < ApplicationRecord
  belongs_to :relation

  validates :order_deadline, :delivery_date, presence: true
end
