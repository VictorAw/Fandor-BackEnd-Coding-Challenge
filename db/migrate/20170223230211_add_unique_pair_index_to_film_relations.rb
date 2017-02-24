class AddUniquePairIndexToFilmRelations < ActiveRecord::Migration[5.0]
  def change
    add_index :film_relations, [:origin_film_id, :related_film_id], unique: true
    add_index :film_relations, [:related_film_id, :origin_film_id], unique: true
  end
end
