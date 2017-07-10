class Restaurant < ApplicationRecord
  has_many :working_relations
  has_many :users, through: :working_relations
  has_many :relations, dependent: :destroy

  has_many :orders, through: :relations
  has_many :delivery_conditions, through: :relations
  has_many :favorites, through: :relations
  has_many :pricing_conditions, through: :relations
  has_many :suppliers, through: :relations
  has_many :order_lines, through: :orders
  has_many :products, through: :order_lines

  belongs_to :group, optional: true

  validates :email, :name, :address, :phone_number, :siret, presence: true
  validates :email, uniqueness: true

  has_attachment :photo
end
