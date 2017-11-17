Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  devise_for :users

  resources :stories do
    resources :slides
    post '/block_up/:id', to: 'slides#block_up'
    post '/block_down/:id', to: 'slides#block_down'
    post '/block_left/:id', to: 'slides#block_left'
    post '/block_right/:id', to: 'slides#block_right'
  end

  post '/publish/:id', to: 'stories#publish'

  resources :ratings, only: :update

  root to: 'pages#home'

  get '/dashboard', to: 'user#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
