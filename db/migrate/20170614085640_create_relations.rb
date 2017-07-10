class CreateRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :relations do |t|
      t.references :restaurant, foreign_key: true
      t.references :supplier, foreign_key: true
      t.integer :order_value_min

      t.timestamps
    end
  end
end
