class AddDefaultInProviders < ActiveRecord::Migration[5.0]
  def change
    change_column :providers, :is_price_infos, :boolean, default: false
  end
end
