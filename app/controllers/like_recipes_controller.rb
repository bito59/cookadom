class LikeRecipesController < ApplicationController

	respond_to :js, :html

	def like_recipe
		@user = current_user
		@recipe = Recipe.find(params[:id])
		@user.like_recipe!(@recipe)
	end

	def unlike_recipe
		@user = current_user
		@like_recipe = @user.like_recipes.find_by_recipe_id(params[:recipe_id])
		@recipe = Recipe.find(params[:recipe_id])
		@like_recipe.destroy!
	end

	def destroy
		@user = current_user
		@user.like_recipes.all.each do |like|
			like.destroy!
		end
		redirect_to user_path(current_user)
		flash.now[:notice] = "Votre book est maintenant vide"
	end

end
