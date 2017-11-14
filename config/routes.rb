Rails.application.routes.draw do
  devise_for :users

  resources :stories do
    resources :slides, except: [:show]
    get '/slides/:x/:y', to: 'slides#show'
  end

  root to: 'pages#home'

  get '/dashboard', to: 'user#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
