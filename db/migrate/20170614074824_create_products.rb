class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :reference
      t.string :public_price
      t.string :packaging
      t.boolean :is_discount
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
