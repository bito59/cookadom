Rails.application.routes.draw do

  devise_for :users
  resources :recipes

  root "cooks#index"

end
