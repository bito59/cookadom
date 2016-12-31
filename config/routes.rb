Rails.application.routes.draw do

  devise_for  :users, 
              :controllers => {
             #     sessions: "mydevise/sessions",
                  registrations: "mydevise/registrations"
              } 
          #    :skip => [:sessions] do
           #     get '/users/sign_in' => 'sessions#new', :as => :new_user_session
            #    post '/users/sign_in' => 'sessions#create', :as => :user_session
             #   get '/users/sign_out' => 'sessions#destroy', :as => :destroy_user_session
             # end
  resources :users, path: "user", only: [:index, :show, :destroy, :update] do
    match 'recipebook', to: 'users#recipebook', via: :get
    get '/users/sign_out' => 'devise/sessions#destroy'
    #resources :comments
  end


  resources :directions, only: [:create, :destroy, :update]

  resources :cooks do 
    resources :recipes
  end

  root "welcome#index"

  match 'add_like_recipe', to: 'like_recipes#like_recipe', via: :post
  match 'unlike_recipe', to: 'like_recipes#unlike_recipe', via: :delete
  match 'recipes', to: 'recipes#browse_recipes', via: :post
  #match 'myrecipes', to: 'recipes#my_recipes', via: :get

end