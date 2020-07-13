Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show, :update]
  resources :sessions, only: [:new, :create, :destroy]
  get '/sessions', to: 'sessions#new'
  namespace :admin do
    resources :users
  end
end
