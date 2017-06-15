class DeliveryCondition < ApplicationRecord
  belongs_to :relation

  validates :order_day, :order_deadline, :delivery_day, :delivery_deadline, presence: true
end
