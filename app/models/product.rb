class Product < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :order_lines, dependent: :destroy
  has_many :pricing_conditions, dependent: :destroy
  belongs_to :supplier

  validates :name, presence: true
  validates_length_of :name, :maximum => 22
  validates :measuring_unit, presence: true, inclusion: { in: ["kgs", "colis", "boites", "pièces", "cols", "paquets", "caisses(24bts)", "cartons(6bts)", "cartons(12bts)"] }
end
