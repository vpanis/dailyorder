class Relation < ApplicationRecord
  has_many :delivery_conditions, dependent: :destroy
  has_many :pricing_conditions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :products, through: :supplier
  has_many :documents
  belongs_to :restaurant
  belongs_to :supplier

end
