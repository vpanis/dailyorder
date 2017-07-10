class ChangeNullInUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :group_id, :integer, null: false
    remove_column :users, :restaurant_id, :integer, null: false
    remove_column :users, :supplier_id, :integer, null: false
    add_column :users, :group_id, :integer
    add_column :users, :restaurant_id, :integer
    add_column :users, :supplier_id, :integer
  end
end
