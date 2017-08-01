class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :is_supplier, :boolean, default: false
  end
end
