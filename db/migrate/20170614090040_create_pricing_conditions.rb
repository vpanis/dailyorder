class CreatePricingConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :pricing_conditions do |t|
      t.references :relation, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :price
      t.integer :quantity_min

      t.timestamps
    end
  end
end
