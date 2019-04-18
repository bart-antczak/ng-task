Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  get 'movies_api', to: 'movies#api_index', as: 'movies_api'
  get 'movie_api/:id', to: 'movies#api_show', as: 'movie_api'

end
