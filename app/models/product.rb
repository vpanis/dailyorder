class Product < ApplicationRecord
  include PgSearch
  pg_search_scope :search_product,
                  against: [ :name ],
                  using: {
                    tsearch: { prefix: true, any_word: true },
                    trigram: {
                      only: [ :name ]
                      }
                    },
                  ignoring: :accents

  has_many :favorites, dependent: :destroy
  has_many :relations, through: :favorites
  has_many :order_lines, dependent: :destroy
  has_many :pricing_conditions, dependent: :destroy
  belongs_to :supplier

  validates :name, presence: true
  validates_length_of :name, :maximum => 22
  validates :measuring_unit, presence: true, inclusion: { in: ["kgs", "col.", "boit.", "pièc.", "cols", "paq.", "c(24)", "c(6)", "c(12)"] }
end
