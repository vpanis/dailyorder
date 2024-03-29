class Supplier < ApplicationRecord
  include PgSearch
  pg_search_scope :search_supplier,
                  against: [ :email, :name ],
                  using: {
                    tsearch: { prefix: true, any_word: true },
                    trigram: {
                      only: [ :name ]
                      }
                    },
                  ignoring: :accents

  has_many :profiles
  has_many :users, through: :profiles
  has_many :relations, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :documents, dependent: :destroy

  has_many :orders, through: :relations
  has_many :delivery_conditions, through: :relations
  has_many :favorites, through: :relations
  has_many :pricing_conditions, through: :relations
  has_many :restaurants, through: :relations
  has_many :order_lines, through: :orders

  validates :email, :name, :address, :zip, :locality, :phone_number, :siret, presence: true
  validates :sector, inclusion: { in: ["Boucherie", "Poissonnerie", "Epicerie", "Crèmerie", "Fruits et légumes", "Boissons", "Vins et spiritueux", "Cafés", "Autres"] }

  has_attachment :photo
end
