class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :role, inclusion: { in: ["Profil admin", "Profil manager"] }
end
