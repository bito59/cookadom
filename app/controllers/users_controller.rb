class UsersController < ApplicationController

before_action :find_cook, only: [:show, :recipebook, :my_recipes]

	def show	
		if @cook.blank?
			@cook=Cook.new
			@new_cook=true
		else
			@recipes = Recipe.where(cook_id: @cook.id)
			@cook.nb_languages?
			@new_cook=false
		end
		@user.nb_liked?
	end

	def update
		@user.slug = nil
		respond_to do |format|
	      if @user.update(user_params)
	      	format.html { redirect_to user_path(@user), notice: 'Votre compte a bien été modifié.' }
	        format.json { head :no_content }
	      else
	      	format.html { redirect_to user_path(@user), notice: 'Problème dans la modification !' }
	        format.json { render json: @Useruser.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
	    if @user.destroy
	        redirect_to root_path, notice: "Votre compte a été supprimé"
	    end
  	end

  	def recipebook
		@recipes = @cook.recipes
	end

	def my_recipes
		@recipes = @cook.recipes
	end

  	private

	def user_params
	   params.require(:user).permit(:pseudo, :avatar, :slug)
	end

  	def find_cook
  		if current_user.present?
			@cook = Cook.find_by(user_id: @user.id)
		end
	end

end
