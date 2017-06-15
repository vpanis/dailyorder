class Group < ApplicationRecord
  has_many :restaurants

  validates :email, :name, :address, :phone_number, :siret, presence: true
end
