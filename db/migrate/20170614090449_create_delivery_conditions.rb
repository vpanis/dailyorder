class CreateDeliveryConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_conditions do |t|
      t.float :order_deadlines, array: true, default: []
      t.integer :order_value_min, default: 0
      t.integer :undelivery_days, array: true, default: []
      t.datetime :holidays, array: true, default: []
      t.references :relation, foreign_key: true, null: false

      t.timestamps
    end
  end
end
