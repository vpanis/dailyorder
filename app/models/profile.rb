class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant, optional: true
  belongs_to :supplier, optional: true

  validates :role, inclusion: { in: ["Profil admin", "Profil manager"] }
  validate :has_company

  def has_company
    if restaurant and supplier
      errors.add(:restaurant, "has to be nil")
    elsif !restaurant and !supplier
      errors.add(:restaurant, "can't be nil")
    end
  end

end
