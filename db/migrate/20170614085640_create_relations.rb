class CreateRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :relations do |t|
      t.references :restaurant, foreign_key: true, null: false
      t.references :supplier, foreign_key: true, null: false

      t.timestamps
    end
  end
end
