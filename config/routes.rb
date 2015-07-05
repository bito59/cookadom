Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :users, only: [:index]
  resources :recipes
  resources :cooks

  root "cooks#index"

end
