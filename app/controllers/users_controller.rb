class UsersController < ApplicationController

before_action :find_user, only: [:show, :update, :destroy]

	def show
		if current_user.present?
			@user = User.find_by(id: current_user)
			@cook = Cook.find_by(user_id: @user.id)
			if @cook.blank?
				@cook=Cook.new
				@new_cook=true
			else
				@recipes = Recipe.where(cook_id: @cook.id)
				@new_cook=false
			end
			@nb_like = current_user.recipes.count
			#@cook.rating
			@cook.nb_languages
		end
	end

	def update
		respond_to do |format|
	      if @user.update(user_params)
	      	format.html { redirect_to @user, notice: 'Votre compte a bien été modifié.' }
	        format.json { head :no_content }
	      else
	      	format.html { redirect_to @user, notice: 'Problème dans la modification !' }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
	    if @user.destroy
	        redirect_to root_path, notice: t('.notice')
	    end
  	end

  	private

	def user_params
	   params.require(:user).permit(:pseudo, :avatar)
	end

  	def find_user
		@user = User.find(params[:id])
	end

end
