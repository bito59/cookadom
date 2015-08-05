class WelcomeController < ApplicationController
  def index
  	#cooks shown on the welcoming page
  	@cooks = Cook.order("RANDOM()").first(3)
  	if user_signed_in?
  		@user = User.find_by(id: current_user) 
  		@cook = Cook.find_by(user_id: @user.id)
  	end
  	#@cooks = Cook.all
  end
end
