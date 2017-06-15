class Favorite < ApplicationRecord
  belongs_to :relation
  belongs_to :product
end
