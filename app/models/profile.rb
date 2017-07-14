class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :role, inclusion: { in: ["Administrateur", "Responsable Cuisine", "Responsable Salle"] }
end
