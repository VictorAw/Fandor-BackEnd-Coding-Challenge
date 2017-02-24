Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :films, only: [:index, :show]
    resources :film_ratings, only: [:create, :update]
  end

  post 'api/film_relations', to: 'api/film_relations#create', defaults: { format: :json }
  delete 'api/film_relations', to: 'api/film_relations#delete', defaults: { format: :json }
end
