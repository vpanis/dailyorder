class AddReferencesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :restaurant, foreign_key: true, null: false
    add_reference :users, :provider, foreign_key: true, null: false
  end
end
