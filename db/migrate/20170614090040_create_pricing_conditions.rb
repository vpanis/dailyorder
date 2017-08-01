class CreatePricingConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :pricing_conditions do |t|
      t.integer :price
      t.integer :quantity_min, default: false
      t.references :relation, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false

      t.timestamps
    end
  end
end
