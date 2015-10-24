class WelcomeController < ApplicationController
  def index
  	if user_signed_in?
  		@user = User.find_by(id: current_user) 
  		@cook = Cook.find_by(user_id: @user.id)
  	end
  end
end
