require 'rails_helper'

RSpec.describe FilmRelation, type: :model do
  describe "validations" do
    it { should validate_presence_of(:origin_film_id) }
    it { should validate_presence_of(:related_film_id) }
    it "should not allow repeat relations" do
      test_film = Film.create!({title: "Test", url_slug: "test", year: 1})
      test_film2 = Film.create!({title: "Test2", url_slug: "test2", year: 1})
      test_relation = FilmRelation.create!({origin_film_id: test_film.id, related_film_id: test_film2.id})
      test_relation2 = FilmRelation.new({origin_film_id: test_film.id, related_film_id: test_film2.id})

      expect(test_relation2.valid?).to be false

      test_relation.destroy
      test_film.destroy
      test_film2.destroy
    end

    it "should allow inverse relations" do
      test_film = Film.create!({title: "Test", url_slug: "test", year: 1})
      test_film2 = Film.create!({title: "Test2", url_slug: "test2", year: 1})
      test_relation = FilmRelation.create!({origin_film_id: test_film.id, related_film_id: test_film2.id})
      test_relation2 = FilmRelation.new({origin_film_id: test_film2.id, related_film_id: test_film.id})

      expect(test_relation2.valid?).to be true

      test_relation.destroy
      test_film.destroy
      test_film2.destroy
    end
  end

  describe "associations" do
    it { should belong_to(:origin_film) }
    it { should belong_to(:related_film) }
  end
end
