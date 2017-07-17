class CreateDeliveryConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_conditions do |t|
      t.references :relation, foreign_key: true
      t.datetime :order_deadline
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
