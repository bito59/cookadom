class UsersController < ApplicationController

	def index
		@user = User.find_by(id: current_user)
		@cook = Cook.find_by(user_id: @user.id)
		@recipes = Recipe.where(user_id: @user.id)
	end

	def destroy
	    @user = User.find_by(id: current_user)
	    @user.destroy

	    if @user.destroy
	        redirect_to root_path, notice: 'Votre compte a été supprimé...'
	    end
  	end

end
