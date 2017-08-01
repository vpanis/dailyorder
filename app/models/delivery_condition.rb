 class DeliveryCondition < ApplicationRecord
  attr_accessor :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
  attr_accessor :sunday_order_day, :monday_order_day, :tuesday_order_day, :wednesday_order_day, :thursday_order_day, :friday_order_day, :saturday_order_day
  attr_accessor :sunday_order_hour, :monday_order_hour, :tuesday_order_hour, :wednesday_order_hour, :thursday_order_hour, :friday_order_hour, :saturday_order_hour

  belongs_to :relation

  validates :order_deadlines, :order_value_min, :undelivery_days, presence: true
end
