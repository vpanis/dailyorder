class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :email
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :siret

      t.timestamps
    end
  end
end
