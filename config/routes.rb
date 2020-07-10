Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :user, only: [:new, :create]
end
