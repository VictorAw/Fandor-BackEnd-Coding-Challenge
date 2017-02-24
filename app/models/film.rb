class Film < ApplicationRecord
  validates :title, :url_slug, :year, presence: true
  validates :url_slug, uniqueness: true

  has_many :film_relations, dependent: :destroy,
    class_name: :FilmRelation,
    primary_key: :id,
    foreign_key: :origin_film_id

  has_many :related_films, dependent: :destroy,
    through: :film_relations,
    source: :related_film

  has_many :film_ratings, dependent: :destroy

  def related_film_ids
    ids = []
    self.related_films.each do |related_film|
      ids << related_film.id
    end

    ids
  end

  def ratings
    ratings = []
    self.film_ratings.each do |film_rating|
      ratings << film_rating.rating
    end

    ratings
  end

  def average_rating
    avg = 0
    # #film_ratings returns a FilmRating ActiveRecord model object
    # therefore, we have to use #rating of that model object to get the actual rating number
    ratings = self.ratings
    if ratings.length > 0
      ratings.each do |rating|
        avg += rating
      end
      
      return avg.to_f / ratings.length.to_f
    end

    "N/A"
  end
end
