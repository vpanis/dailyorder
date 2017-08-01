class CreateOrderLines < ActiveRecord::Migration[5.0]
  def change
    create_table :order_lines do |t|
      t.float :quantity
      t.references :product, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false

      t.timestamps
    end
  end
end
