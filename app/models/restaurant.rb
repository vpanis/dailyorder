class Restaurant < ApplicationRecord
  has_many :profiles, dependent: :destroy
  has_many :users, through: :profiles
  has_many :relations, dependent: :destroy
  has_many :documents, dependent: :destroy

  has_many :orders, through: :relations
  has_many :delivery_conditions, through: :relations
  has_many :favorites, through: :relations
  has_many :pricing_conditions, through: :relations
  has_many :suppliers, through: :relations
  has_many :order_lines, through: :orders
  has_many :products, through: :order_lines

  validates :email, :name, :address, :zip, :locality, :phone_number, :siret, presence: true
  validates_length_of :name, :maximum => 25

  has_attachment :photo
end
