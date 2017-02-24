class CreateFilmRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :film_relations do |t|
      t.integer :origin_film_id, null: false
      t.integer :related_film_id, null: false

      t.timestamps
    end

    add_index :film_relations, :origin_film_id
    add_index :film_relations, :related_film_id
  end
end
