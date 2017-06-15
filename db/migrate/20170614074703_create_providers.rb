class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :email
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :siret
      t.boolean :is_price_infos

      t.timestamps
    end
  end
end
