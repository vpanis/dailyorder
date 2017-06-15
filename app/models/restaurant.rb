class Restaurant < ApplicationRecord
  has_many :users
  has_many :relations, dependent: :destroy

  has_many :orders, through: :relations
  has_many :delivery_conditions, through: :relations
  has_many :favorites, through: :relations
  has_many :pricing_conditions, through: :relations
  has_many :providers, through: :relations
  has_many :order_lines, through: :orders
  has_many :products, through: :order_lines

  belongs_to :group, optional: true

  validates :email, :name, :address, :phone_number, :siret, presence: true

  has_attachment :photo
end
