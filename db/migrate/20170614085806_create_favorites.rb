class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :relation, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
