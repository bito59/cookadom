Rails.application.routes.draw do

  get 'welcome/index'

  devise_for :users 
  #controllers: { registrations: "registrations" }
  #, controllers: { sessions: 'users/sessions' }

  resources :users, only: [:index, :destroy]
  resources :recipes
  resources :cooks

  	#devise_scope :user do
    #	get "delete_user", :to => "devise/registrations#destroy", :as => :edit_user_registration
	#end

	#as :user do
	#	get 'users', :to => 'users#show', as: :user_root
		#get 'user', :to => 'users#destroy', :via => :delete, as: :user
#	end
	#match 'users/:id' => 'users#destroy', :via => :delete, :as => :user

	root "welcome#index"

end
