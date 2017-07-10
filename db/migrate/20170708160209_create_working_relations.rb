class CreateWorkingRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :working_relations do |t|
      t.references :user, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
