class Group < ApplicationRecord
  has_many :users
  has_many :restaurants

  validates :email, :name, :address, :phone_number, :siret, presence: true

  has_attachment :photo
end
