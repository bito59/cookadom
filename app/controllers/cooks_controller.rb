class CooksController < ApplicationController
include ActionView::Helpers::TextHelper
before_action :find_cook, only: [:update, :edit, :destroy]
before_action :authenticate_user!, except: [:index]

	def index
		@cooks = Hash.new
		if params[:formatted_address].present?
			@adress = params[:formatted_address]
			@message = "à proximité"
			coordinates = [params[:lat], params[:lng]]
			Cook.all.each do |cook|
				dist = cook.distance_from(coordinates).round(1).to_s
				nb_recipes = Recipe.where(:cook_id == cook.id).count
				nb_avis = Comment.where(:cook_id == cook.id).count
				nb_stars = Comment.where(:cook_id == cook.id).average(:star)
				if cook.distance_from(coordinates).to_f < cook.working_distance.to_f + 20
					@cooks[cook.name] = {details: cook, distance: dist, nb_recipes: nb_recipes, nb_avis: nb_avis, nb_stars: nb_stars}
					if cook.distance_from(coordinates) < cook.working_distance.to_f
						@cooks[cook.name][:in_range] = "OK"
					else
						@cooks[cook.name][:in_range] = "QUESTION"
					end
				end
			end
			if @cooks.blank?
				message = "Aucun cook n'a été trouvé autour de cette addresse..."
			else
				message = pluralize(@cooks.count, "cook trouvé") + " autour de cette adresse..."
			end
		else
  			#@cooks = Cook.order("RANDOM()").first(3)
  			@adress = nil
			@message = ""
			Cook.all.each do |cook|
				nb_recipes = Recipe.where(:user_id == cook.user_id).count
				nb_avis = Comment.where(:cook_id == cook.id).count
				nb_stars = Comment.where(:cook_id == cook.id).average(:star)
				@cooks[cook.name] = {details: cook, distance: "", nb_recipes: nb_recipes, nb_avis: nb_avis, nb_stars: nb_stars}
				@cooks[cook.name][:in_range] = ""
			end
			if @cooks.blank?
				message = "Aucun cook dans la BDD : initialisation nécessaire"
			else
				message = pluralize(@cooks.count, "cook trouvé...")
			end
		end
		flash.now[:notice] = message
	end

	def new
		@cook = current_user.build_cook
	end

	def create
		@cook = current_user.build_cook(cook_params)
		if @cook.save
			redirect_to users_path, notice: "Le cuisinier a bien été crée !"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @cook.update(cook_params)
			redirect_to users_path, notice: "Le cuisinier a bien été updaté !"
		else
			render 'edit'
		end
	end

	def destroy
		Recipe.where(user_id: @cook.user_id).destroy_all
		@cook.destroy
		redirect_to users_path, notice: 'Le cuisinier a bien été détruit avec les recettes...'
	end

	private

	def find_cook
		@cook = Cook.find(params[:id])
	end

	def cook_params
		params.require(:cook).permit(:name, :postal_code, :working_distance, :introduction)
	end

end
