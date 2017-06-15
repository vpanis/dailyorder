class AddDefaultInProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :is_discount, :boolean, default: false
  end
end
