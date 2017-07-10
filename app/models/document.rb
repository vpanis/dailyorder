class Document < ApplicationRecord
  belongs_to :order
  has_attachment :file, accept: [:pdf]

  delegate :relation, :to => :order, :allow_nil => false

  validates :title, presence: true
  validates :document_type, presence: true, inclusion: { in: ["Bon de commande", "Bon de livraison", "Facture", "Relevé de factures"] }
end
