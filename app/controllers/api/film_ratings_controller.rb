class Api::FilmRatingsController < ApplicationController
  protect_from_forgery except: :create
  protect_from_forgery except: :update

  def create
    @film_rating = FilmRating.new(film_ratings_params)

    if @film_rating.save
      render :show
    else
      render json: @film_rating.errors.full_messages, status: 422
    end
  end

  def update
    @film_rating = FilmRating.find_by_id(params[:id])

    if @film_rating
      if @film_rating.update(film_ratings_params)
        render :show
      else
        render json: @film_rating.errors.full_messages, status: 422
      end
    else
      render json: "Film Rating not found", status: 404
    end
  end

  private
  def film_ratings_params
    params.require(:film_rating).permit(:rating, :film_id, :user_id)
  end
end
