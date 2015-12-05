Rails.application.routes.draw do

  devise_for :users 

  resources :comments
  resources :users, only: [:index, :show, :destroy, :update] 
  resources :directions, only: [:create, :destroy, :update]
  resources :cooks do 
    resources :recipes
  end
  resources :like_recipes

  root "welcome#index"
  #get 'welcome/index'

  match 'add_like_recipe', to: 'like_recipes#like_recipe', via: :post
  match 'unlike_recipe', to: 'like_recipes#unlike_recipe', via: :delete
  match 'recipes', to: 'recipes#browse_recipes', via: :post
  match 'myrecipes', to: 'recipes#my_recipes', via: :get

end