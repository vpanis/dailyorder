class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :document_type
      t.boolean :sent, default: false
      t.references :order, foreign_key: true
      t.references :relation, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
