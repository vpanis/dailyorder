class AddColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :measuring_unit, :string
  end
end
