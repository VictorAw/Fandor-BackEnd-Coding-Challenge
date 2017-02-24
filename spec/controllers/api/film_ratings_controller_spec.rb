require 'rails_helper'

RSpec.describe Api::FilmRatingsController, type: :controller do
  describe "POST #create" do
    before(:all) do
      @film = Film.create!({title: "Test", url_slug: "test", year: 1})
    end

    before(:each) do
      @film.reload
    end

    after(:all) do
      @film.destroy
    end

    describe "with valid params" do
      it "renders the newly created rating" do
        post :create, params: {film_rating: {rating: 5, film_id: @film.id, user_id: 1}, format: :json}
        expect(response).to render_template(:show)
      end
    end

    describe "with invalid params" do
      it "returns a 422 error" do
        post :create, params: {film_rating: {rating: 3}, format: :json}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH #update" do
    describe "with valid params" do
      before(:all) do
        @film = Film.create!({title: "Test", url_slug: "test", year: 1})
        @film_rating = FilmRating.create!({rating: 3, film_id: @film.id, user_id: 1})
      end

      before(:each) do
        @film.reload
        @film_rating.reload
      end

      after(:all) do
        @film.destroy
        @film_rating.destroy
      end
      
      describe "if rating exists" do
        it "renders the newly created object" do
          patch :update, params: {id: @film_rating.id, film_rating: {rating: 5, film_id: @film.id, user_id: 1}, format: :json}
          expect(response).to render_template(:show)
        end
      end
      
      describe "if rating does not exist" do
        it "renders a 404 error" do
          patch :update, params: {id: 500, film_rating: {rating: 5, film_id: @film.id, user_id: 1}, format: :json}
          expect(response.status).to eq(404)
        end
      end
      
    end

    describe "with invalid params" do
      before(:all) do
        @film = Film.create!({title: "Test", url_slug: "test", year: 1})
        @film_rating = FilmRating.create!({rating: 3, film_id: @film.id, user_id: 1})
      end

      before(:each) do
        @film.reload
        @film_rating.reload
      end

      after(:all) do
        @film.destroy
        @film_rating.destroy
      end

      it "does not modify the object" do
        patch :update, params: {id: @film_rating.id, film_rating: {invalid_param: 3}, format: :json}
        expect(response.status).to eq(200)
        film_rating = FilmRating.find_by_id(@film_rating.id)
        expect(film_rating.rating).to eq(3)
        expect(film_rating.film_id).to eq(@film.id)
        expect(film_rating.user_id).to eq(1)
      end
    end
  end
end
