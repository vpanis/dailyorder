class AddDefaultInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :position, :string, default: ""
    change_column :users, :profile, :string, default: ""
  end
end
