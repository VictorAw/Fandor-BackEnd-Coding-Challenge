Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :films, only: [:index, :show]
  end

  post 'api/film_ratings', to: 'api/film_ratings#create', defaults: { format: :json }
  patch 'api/film_ratings', to: 'api/film_ratings#update', defaults: { format: :json}
  put 'api/film_ratings', to: 'api/film_ratings#update', defaults: { format: :json}
  
  post 'api/film_relations', to: 'api/film_relations#create', defaults: { format: :json }
  delete 'api/film_relations', to: 'api/film_relations#delete', defaults: { format: :json }
end
