require 'rails_helper'

RSpec.describe Api::FilmsController, type: :controller do
  describe "GET #index" do
    it "renders the view of all films" do
      get :index, {format: :json}
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders the view of a specific film when given a valid id" do
      test_film = Film.create!({title: "Test", url_slug: "test", year: 1})
      get :show, params: {id: test_film.id, format: :json}
      expect(response).to render_template(:show)

      test_film.destroy
    end

    it "renders a 404 error when not provided a valid id" do
      get :show, params: {id: 100, format: :json}
      expect(response.status).to eq(404)
    end
  end
end
