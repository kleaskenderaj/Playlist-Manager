Rails.application.routes.draw do
  root 'pages#home'
  get '/home', to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :playlists
  resources :mediums
  resources :devices
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end