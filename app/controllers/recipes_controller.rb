class RecipesController < ApplicationController
before_action :find_recipe, only: [:show, :update, :edit, :destroy]
before_action :authenticate_user!, except: [:index, :show]


	def index
		if params[:id].blank?
			@recipes = Recipe.all.order("created_at DESC")
		else
			@cook = Cook.find_by(id: params[:id])
			@recipes = Recipe.where(cook_id: params[:id]).order("created_at DESC")
		end
	end

	def show
		@cook = Cook.find_by(id: @recipe.cook_id)
		#max_rank = Direction.where(recipe_id: @recipe.id).count
		@directions = Direction.where(recipe_id: @recipe.id).order("rank ASC")
		get_rank_list()
		#@rank_list = []
		#@directions.count.times do |n|
			#@rank_list << {value: (n+1), text: (n+1).to_s}
		#end
		#@recipe = Recipe.find_by(id: params[])
		#@dishtype = Dishtype.find_by(id: @recipe.dishtype_id)
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
		respond_to do |format|
		#recipe_params = {params.name => params.value}
	      if @recipe.update(recipe_params)
	        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: 'edit' }
	        format.json { render json: @recipe.errors, status: :unprocessable_entity }
	      end
	    end


		#if @recipe.update(recipe_params)
		#	redirect_to @recipe
		#else
		#	render 'edit'
		#end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted the recipe"
	end

	private 

	def recipe_params
		params.require(:recipe).permit(	:title, :description, :image, :dish_type,
										ingredients_attributes: [:id, :name, :_destroy],
										directions_attributes: [:id, :step, :_destroy]
										)
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

end
