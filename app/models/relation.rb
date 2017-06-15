class Relation < ApplicationRecord
  has_many :pricing_conditions, dependent: :destroy
  has_many :delivery_conditions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :restaurant
  belongs_to :provider

  validates :order_value_min, presence: true
end
