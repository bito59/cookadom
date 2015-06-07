Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :users, only: [:index]
  resources :recipes

  root "cooks#index"

end
