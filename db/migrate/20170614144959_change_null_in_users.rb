class ChangeNullInUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :restaurant_id, :integer, null: false
    remove_column :users, :provider_id, :integer, null: false
    add_column :users, :restaurant_id, :integer
    add_column :users, :provider_id, :integer
  end
end
