Rails.application.routes.draw do

  root to: "links#index"

  resources :links, only: [:index, :edit, :update, :destroy]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create, :update, :index]
      get 'hot', to: 'links#top'
    end
  end
end
