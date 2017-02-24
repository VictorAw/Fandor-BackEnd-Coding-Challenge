class FilmRelation < ApplicationRecord
  validates :origin_film_id, :related_film_id, presence: true
  validates :origin_film_id, uniqueness: {scope: :related_film_id}

  belongs_to :origin_film,
    class_name: :Film,
    primary_key: :id,
    foreign_key: :origin_film_id

  belongs_to :related_film,
    class_name: :Film,
    primary_key: :id,
    foreign_key: :related_film_id

  after_destroy :destroy_inverses, if: :has_inverse?

  private

  def destroy_inverses
    inverses.destroy_all
  end

  def inverses
    self.class.where(inverse)
  end

  def has_inverse?
    self.class.exists?(inverse)
  end

  def inverse
    { 
      origin_film_id: self.related_film_id,
      related_film_id: self.origin_film_id
    }
  end
end
