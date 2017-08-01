class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :email
      t.string :name
      t.string :address
      t.string :zip
      t.string :locality
      t.string :phone_number
      t.string :sector
      t.string :siret
      t.boolean :is_price_infos, default: false

      t.timestamps
    end
  end
end
