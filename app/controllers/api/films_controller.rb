class Api::FilmsController < ApplicationController
  def index
    @films = Film.all
    render :index
  end

  def show
    @film = Film.find_by_id(params[:id])
    if @film
      render :show
    else
      render json: "Film not found", status: 404
    end
  end
end
