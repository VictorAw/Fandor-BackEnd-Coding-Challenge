class CreateFilmRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :film_ratings do |t|
      t.integer :rating, null: false
      t.integer :film_id, null: false
      
      t.timestamps
    end

    add_index :film_ratings, :film_id
    add_index :film_ratings, :rating
  end
end
