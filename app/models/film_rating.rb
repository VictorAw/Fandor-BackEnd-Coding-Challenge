class FilmRating < ApplicationRecord
  validates :rating, :film_id, :user_id, presence: true
  validates :film_id, uniqueness: {scope: :user_id}

  belongs_to :film
end
