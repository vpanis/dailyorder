class AddDefaultInSuppliers < ActiveRecord::Migration[5.0]
  def change
    change_column :suppliers, :is_price_infos, :boolean, default: false
  end
end
