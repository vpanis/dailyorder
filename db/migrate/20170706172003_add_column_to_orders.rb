class AddColumnToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :status, :string, default: "Validée"
    add_reference :orders, :user, foreign_key: true, null: false
  end
end
