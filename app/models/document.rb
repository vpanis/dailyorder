class Document < ApplicationRecord
  belongs_to :relation, optional: true
  belongs_to :order, optional: true
  belongs_to :restaurant, optional: true
  belongs_to :supplier, optional: true
  has_attachment :file, accept: [:pdf]

  validates :title, presence: true
  validates :document_type, presence: true, inclusion: { in: ["Bon de commande", "Relevé de commandes", "Bon de livraison", "Facture", "Relevé de factures"] }
end
