class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :role
      t.references :user, foreign_key: true, null: false
      t.references :restaurant, foreign_key: true
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
