class RecipesController < ApplicationController

	before_action :find_recipe, only: [:show, :update, :edit, :destroy]
	before_action :find_cook, only: [:index, :create, :show]

	def index
		find_cook
		@recipes = @cook.recipes.order("created_at DESC")
	end

	def my_recipes
		@recipes = current_user.recipes
	end

	def browse_recipes
		if params[:lat] == "no"
			@recipes = Recipe.all.order("created_at DESC")
		else
			search_recipes([params[:lat], params[:lng]])
		end
		message
		flash.now[:notice] = @message
	end

	def show
		@directions = Direction.where(recipe_id: @recipe.id).order("rank ASC")
		get_rank_list()
		get_dishtype_list()
		@nb_votes = 0
		@nb_liked = current_user.nb_liked?
	end

	def create
		@recipe = @cook.recipes.build(
			title: "Recette " + (@cook.recipes.count + 1).to_s, 
			intro: 'Introduction',
			description: 'Description',
			duration: 10, 
			stars: 0,
			dishtype_id: 0)

		if @recipe.save
			redirect_to [@cook, @recipe], notice: "La nouvelle recette est créée"
		else
			redirect_to current_user, notice: "Impossible de créer la recette"
		end
	end

	def edit
	end

	def update
		params[:duration].to_i
		respond_to do |format|
	      if @recipe.update(recipe_params)
	        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: 'edit' }
	        format.json { render json: @recipe.errors, status: :unprocessable_entity }
	      end
	    end

	end

	def destroy
		@recipe.destroy
		redirect_to user_path(current_user), notice: "La recette a bien été supprimée"
	end

	private 

	def recipe_params
		params.require(:recipe).permit(	:title, :description, :duration, :image, :dish_type,:dist, :in_range,
										ingredients_attributes: [:id, :name, :_destroy],
										directions_attributes: [:id, :step, :_destroy],
										)
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

	def find_cook
		@cook = Cook.find_by_id(params[:cook_id])
	end

	def search_recipes(coordinates)
		search_cooks(coordinates)
		@recipes = Array.new
		@cooks.each do |cook|
			cook.recipes.each do |recipe|
				recipe.distance = cook.distance
				recipe.in_range = cook.in_range
				@recipes << recipe
			end
		end
	end

	def message
		if params[:lat] == "no" && @recipes.empty?
			@message = "Aucune recette dans la BDD : initialisation nécessaire"
		elsif params[:lat] == "no"
			@message = @recipes.count.to_s + " recette".pluralize(@recipes.count) + " trouvée".pluralize(@recipes.count)
		elsif @recipes.empty?
			@message = "Aucune recette n'a été trouvée autour de cette addresse..."
	    elsif
			@message = @recipes.count.to_s + " recette".pluralize(@recipes.count) + " trouvée".pluralize(@recipes.count) + " autour de cette adresse..."
			@recipes = @recipes.sort_by { |v| v.distance }
	    end
	end	

end
