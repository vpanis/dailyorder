class Product < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :order_lines, dependent: :destroy
  has_many :pricing_conditions, dependent: :destroy
  belongs_to :provider

  validates :name, presence: true
  validates :measuring_unit, presence: true, inclusion: { in: ["kgs", "colis", "boites", "pièces", "cols", "paquets", "caisses de 24", "cartons de 6", "cartons de 12"] }
end
