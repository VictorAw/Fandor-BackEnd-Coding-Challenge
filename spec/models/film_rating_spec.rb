require 'rails_helper'

RSpec.describe FilmRating, type: :model do
  describe "validations" do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:film_id) }
    it { should validate_presence_of(:user_id) }
    it "should not allow users to create two ratings on the same film" do
      test_rating = FilmRating.create({rating: 5, film_id: 1, user_id: 1})
      test_rating2 = FilmRating.new({rating: 2, film_id: 1, user_id: 1})

      expect(test_rating2.valid?).to be false

      test_rating.destroy
    end
  end

  describe "associations" do
    it { should belong_to(:film) }
  end
end
