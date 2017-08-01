class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :document_type
      t.boolean :sent, default: false
      t.references :order, foreign_key: true, null: false

      t.timestamps
    end
  end
end
