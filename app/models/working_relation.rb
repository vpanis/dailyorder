class WorkingRelation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :role, presence: true
end
