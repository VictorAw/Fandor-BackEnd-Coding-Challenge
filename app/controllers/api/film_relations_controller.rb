class Api::FilmRelationsController < ApplicationController
  protect_from_forgery except: :create
  protect_from_forgery except: :delete

  def create
    @film_relation = FilmRelation.new(film_relation_params)

    if @film_relation.save
      render :show
    else
      render json: @film_relation.errors.full_messages, status: 422
    end
  end

  def delete
    origin_film_id = params[:film_relation][:origin_film_id]
    related_film_id = params[:film_relation][:related_film_id]
    @film_relation = FilmRelation.find_by_origin_film_id_and_related_film_id(origin_film_id, related_film_id)

    if @film_relation && @film_relation.destroy
      render :show
    else
      render json: "Film Relation not found", status: 404
    end
  end

  private
  def film_relation_params
    params.require(:film_relation).permit(:origin_film_id, :related_film_id);
  end
end
