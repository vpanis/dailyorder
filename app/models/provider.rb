class Provider < ApplicationRecord
  has_many :users
  has_many :relations, dependent: :destroy
  has_many :products, dependent: :destroy

  has_many :orders, through: :relations
  has_many :delivery_conditions, through: :relations
  has_many :favorites, through: :relations
  has_many :pricing_conditions, through: :relations
  has_many :restaurants, through: :relations
  has_many :order_lines, through: :orders

  validates :email, :name, :address, :phone_number, :siret, presence: true

  has_attachment :photo
end
