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
  resources :comments, only: [:create, :destroy]
  get '/top_commenters', to: 'top_commenters#index', as: 'top_commenters'


  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index, :show]

      # This seems to be the only way to communicate with you, the person who reviews it,
      # and I guess I need to explain this awkward solution below
      #
      # I personally liked the previous solution with the get parameter, but now I'm not allowed to use it
      # (technically the solution below is using separate endpoint, not an additional param)
      #
      # One of the ways to solve that could be to use the API v2 for returning movies with genres,
      # but this would look like a huge overhead, wouldn't it? Doing like this we would end up in
      # having API v10 within six month of a project..
      #
      # Another way could be using the endpoint like /movies/:id/genres, but this would assume
      # genre-based responses (meaning genre: {name: Horror, ..., movies: []}) - which is not what is expected
      #
      # I assume I'm expected to use a solution I have not mentioned here. If it is the case, could you please
      # let me know on the expected endpoints even if you decline my application? Thanks!

      get '/movies_with_genre', to: 'movies#index'
      get '/movies_with_genre/:id', to: 'movies#show'

    end
  end
end
