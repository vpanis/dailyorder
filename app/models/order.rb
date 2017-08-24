class Order < ApplicationRecord
  has_many :order_lines, dependent: :destroy
  has_many :documents, dependent: :destroy
  belongs_to :relation
  belongs_to :user

  delegate :restaurant, :to => :relation
  delegate :supplier, :to => :relation

  validates :status, presence: true, inclusion: { in: ["En cours", "Validée", "Envoyée"] }

  accepts_nested_attributes_for :order_lines
end
