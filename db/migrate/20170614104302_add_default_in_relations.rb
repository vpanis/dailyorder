class AddDefaultInRelations < ActiveRecord::Migration[5.0]
  def change
    change_column :relations, :order_value_min, :integer, default: 0
  end
end
