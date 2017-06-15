class Order < ApplicationRecord
  has_many :order_lines, dependent: :destroy
  belongs_to :relation

  validates :delivery_date, presence: true
end
