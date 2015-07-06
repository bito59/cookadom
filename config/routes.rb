Rails.application.routes.draw do

  devise_for :users
  #, controllers: { sessions: 'users/sessions' }

  resources :users, only: [:index, :destroy]
  resources :recipes
  resources :cooks

	as :user do
		get 'users', :to => 'users#show', as: :user_root
		#get 'user', :to => 'users#destroy', :via => :delete, as: :user
	end
	#match 'users/:id' => 'users#destroy', :via => :delete, :as => :user

	root "cooks#index"

end
