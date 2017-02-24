class AddUserIdToFilmRatings < ActiveRecord::Migration[5.0]
  def change
    add_column :film_ratings, :user_id, :integer, null: false

    add_index :film_ratings, [:film_id, :user_id], unique: true
  end
end
