class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :reference
      t.string :public_price
      t.string :measuring_unit
      t.string :packaging
      t.boolean :is_discount, default: false
      t.references :supplier, foreign_key: true, null: false

      t.timestamps
    end
  end
end
