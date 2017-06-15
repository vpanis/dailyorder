class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :relation, foreign_key: true
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
