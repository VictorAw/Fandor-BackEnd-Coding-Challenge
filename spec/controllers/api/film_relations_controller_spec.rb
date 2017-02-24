require 'rails_helper'

RSpec.describe Api::FilmRelationsController, type: :controller do
  describe "POST #create" do
    before(:all) do
      @film1 = Film.create!({title: "Test", url_slug: "test", year: 1})
      @film2 = Film.create!({title: "Test2", url_slug: "test2", year: 1})
    end

    before(:each) do
      @film1.reload
      @film2.reload
    end

    after(:all) do
      @film1.destroy
      @film2.destroy
    end

    describe "with valid params" do
      it "renders the newly created relation" do
        post :create, params: {film_relation: {origin_film_id: @film1.id, related_film_id: @film2.id}, format: :json}
        expect(response).to render_template(:show)
      end
    end

    describe "with invalid params" do
      it "returns a 422 error" do
        post :create, params: {film_relation: {origin_film_id: 1}, format: :json}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #delete" do
    before(:each) do
      @film1 = Film.create!({title: "Test", url_slug: "test", year: 1})
      @film2 = Film.create!({title: "Test2", url_slug: "test2", year: 1})

      @film_relation = FilmRelation.create!({origin_film_id: @film1.id, related_film_id: @film2.id})
    end

    after(:each) do
      @film1.destroy
      @film2.destroy
      @film_relation.destroy
    end

    describe "with valid id" do
      it "deletes the object and renders an empty object" do
        delete :delete, params: {film_relation: {
                                                  origin_film_id: @film_relation.origin_film_id, 
                                                  related_film_id: @film_relation.related_film_id},
                                 format: :json}
        expect(FilmRelation.find_by_origin_film_id_and_related_film_id(@film_relation.origin_film_id, @film_relation.related_film_id)).to eq(nil)
        expect(response).to render_template(:show)
      end
    end

    describe "with invalid id" do
      it "returns a 404 error" do
        delete :delete, params: {film_relation: {origin_film_id: 500, related_film_id: 501}, format: :json}
        expect(response.status).to eq(404)
      end
    end
  end
end
