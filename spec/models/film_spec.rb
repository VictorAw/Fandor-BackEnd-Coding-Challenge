require 'rails_helper'

RSpec.describe Film, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url_slug) }
    it { should validate_presence_of(:year) }
    
    it "should validate uniqueness of url_slug" do
      test_film = Film.create!({title: "Test", url_slug: "test", year: 1})
      test_film2 = Film.new({title: "Test2", url_slug: "test", year: 2})
      expect(test_film2.valid?).to be false
      test_film.destroy
    end
  end

  describe "associations" do
    it { should have_many(:film_relations) }
    it { should have_many(:related_films) }
    it { should have_many(:film_ratings) }
   
    it "should destroy FilmRelations when destroyed" do
      test_film = Film.create!({title: "Test", url_slug: "test", year: 1})
      test_film2 = Film.create!({title: "Test2", url_slug: "test2", year: 1})
      test_relation = FilmRelation.create!({origin_film_id: test_film.id, related_film_id: test_film2.id})
      test_relation2 = FilmRelation.create!({origin_film_id: test_film2.id, related_film_id: test_film.id})

      test_film.destroy

      expect(FilmRelation.find_by_id(test_relation.id)).to eq(nil)
      expect(FilmRelation.find_by_id(test_relation2.id)).to eq(nil)

      test_film.destroy
      test_film2.destroy
      test_relation.destroy
      test_relation2.destroy
    end
  end

  describe "description" do
    it "defaults to 'N/A'" do
      test_film = Film.create!({title: "Test", url_slug: "test", year: 1})

      expect(test_film.description).to eq("N/A")

      test_film.destroy
    end
  end

  describe "#related_film_ids" do
    before(:all) do
      @test_film = Film.create!({title: "Test", url_slug: "test", year: 1})
    end

    before(:each) do
      @test_film.reload
    end

    after(:all) do
      @test_film.destroy
    end

    it "Returns an array" do
      expect(@test_film.related_film_ids).to be_instance_of(Array)
    end

    it "Should be empty by default" do
      expect(@test_film.related_film_ids).to be_empty
    end

    describe "After relations are created" do
      before(:all) do
        # Due to time constraints, I will be creating an actual
        # Film Relation to test the contents of the array
        @test_film2 = Film.create({title: "Test2", url_slug: "test2", year: 1})
        @test_relation = FilmRelation.create({origin_film_id: @test_film.id, related_film_id: @test_film2.id})
      end

      before(:each) do
        @test_film2.reload
        @test_relation.reload
      end

      after(:all) do
        @test_film2.destroy
        @test_relation.destroy
      end

      it "Should not be empty after a relation is created" do
        #debugger
        expect(@test_film.related_film_ids).to_not be_empty
      end

      it "Should contain related film ids" do
        expect(@test_film.related_film_ids[0]).to eq(@test_film2.id)
      end
    end
  end

  describe "Ratings and Average Rating" do
    describe "#rating" do
      before(:all) do
        @test_film = Film.create({title: "Test", url_slug: "test", year: 1})
      end

      before(:each) do
        @test_film.reload
      end

      after(:all) do
        @test_film.destroy
      end

      it "returns an array" do
        expect(@test_film.ratings).to be_instance_of(Array)
      end

      it "Should be empty by default" do
        expect(@test_film.ratings).to be_empty
      end
     
      describe "After ratings are created" do  
        before(:all) do
          # Due to time constraints, I will be creating an actual
          # Film Rating to test the contents of the array
          @test_rating = FilmRating.create({rating: 5, film_id: @test_film.id, user_id: 1})
        end

        after(:all) do
          @test_rating.destroy
        end

        it "should not be empty after a rating is created" do
          expect(@test_film.ratings[0]).to eq(@test_rating.rating)
        end
      end
    end
   
    describe "#average_rating" do
      before(:all) do
        @test_film = Film.create({title: "Test", url_slug: "test", year: 1})
      end

      before(:each) do
        @test_film.reload
      end

      after(:all) do
        @test_film.destroy
      end

      it "returns 'N/A' if there are no ratings" do
        expect(@test_film.average_rating).to eq("N/A")
      end

      describe "after ratings are created" do
        before(:all) do
          # Due to time constraints, I will be creating an actual
          # Film Rating to test the contents of the array
          @test_rating = FilmRating.create({rating: 5, film_id: @test_film.id, user_id: 1})
          @test_rating2 = FilmRating.create({rating: 1, film_id: @test_film.id, user_id: 2})
        end

        before(:each) do
          @test_rating.reload
          @test_rating2.reload
        end

        after(:all) do
          @test_rating.destroy
          @test_rating2.destroy
        end
        
        it "should return the correct average rating" do
          expect(@test_film.average_rating).to eq(3)
        end

        it "should return a float" do
          expect(@test_film.average_rating).to be_instance_of(Float)
        end
      end
    end 
  end
end
