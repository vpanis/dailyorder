class Relation < ApplicationRecord
  has_many :pricing_conditions, dependent: :destroy
  has_many :delivery_conditions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :products, through: :supplier
  has_many :documents, through: :orders
  belongs_to :restaurant
  belongs_to :supplier

  validates :order_value_min, presence: true
end
