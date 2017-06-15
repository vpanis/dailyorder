class AddDefaultInPricingConditions < ActiveRecord::Migration[5.0]
  def change
    change_column :pricing_conditions, :quantity_min, :integer, default: 0
  end
end
