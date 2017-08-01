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

  def self.import(file, supplier)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by(name: row["name"]) || new
      product.attributes = row.to_hash.slice(*row.to_hash.keys)
      product.supplier = supplier
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
