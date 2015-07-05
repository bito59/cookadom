class RecipesController < ApplicationController
before_action :find_recipe, only: [:show, :update, :edit, :destroy]
before_action :authenticate_user!, except: [:index, :show]

	def index
		if params[:user_id].blank?
			@recipes = Recipe.all.order("created_at DESC")
		else
			@cook = User.find_by(id: params[:user_id])
			@recipes = Recipe.where(user_id: params[:user_id]).order("created_at DESC")

			unless params[:dishtype].blank?
				@dishtype_id = Dishtype.find_by(name: params[:dishtype]).id
				@recipes = @recipes.where(dishtype_id: @dishtype_id).order("created_at DESC")
			end
		end
	end

	def show
		@cook = Cook.find_by(user_id: @recipe.user_id)
		@dishtype = Dishtype.find_by(id: @recipe.dishtype_id)
	end

	def new 
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: "Succesfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted the recipe"
	end

	private 

	def recipe_params
		params.require(:recipe).permit(	:title, :description, :image, :dishtype_id,
										ingredients_attributes: [:id, :name, :_destroy],
										directions_attributes: [:id, :step, :_destroy]
										)
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end
end
