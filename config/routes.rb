Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  devise_for :users

  resources :stories do
    resources :slides
  end

  root to: 'pages#home'

  get '/dashboard', to: 'user#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
