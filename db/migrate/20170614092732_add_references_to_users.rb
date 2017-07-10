class AddReferencesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :group, foreign_key: true, null: false
    add_reference :users, :restaurant, foreign_key: true, null: false
    add_reference :users, :supplier, foreign_key: true, null: false
  end
end
