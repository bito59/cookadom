class CooksController < ApplicationController
include ActionView::Helpers::TextHelper
before_action :find_cook, only: [:update, :edit, :destroy]
before_action :authenticate_user!, except: [:index]

	def index
		if params[:lat] == "no"
			redirect_to cooks_path
		else
			if params[:lat].nil?
				show_all
			else
				search_cooks([params[:lat], params[:lng]])
			end
			message
			flash.now[:notice] = @message
		end
	end

	def create
		@cook = current_user.build_cook(cook_params)
		if @cook.save
			redirect_to user_path(current_user), notice: "Le cuisinier a bien été crée !"
		else
			redirect_to user_path(current_user), notice: "Impossible de créer le cook"
		end
	end

	def edit
	end

	def update
		respond_to do |format|
	      if @cook.update(cook_params)
	        format.json { head :no_content }
	        format.js { render :layout => false, directions: @directions, rank_list: @rank_list }
	      else
	        format.json { render json: @cook.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
		@cook.destroy
		redirect_to user_path(current_user), notice: 'Le cuisinier a bien été supprimé avec les recettes...'
	end

	private

	def cook_params
		params.require(:cook).permit(:title, :lat, :lng, :phone_number,
			:formatted_address, :street_number, :route, :locality, 
			:postal_code, :administrative_area_level_1, :country,
			:working_distance, :introduction, :gender, 
			:language1, :language2, 
			:language3)
	end

	def find_cook
		@cook = Cook.find(params[:id])
	end

	def show_all
		@adress = nil
		@proximite = ""
		@cooks = Cook.all
		@cooks.each do |cook|
			cook.rating
		end
	end

	def message
		if params[:lat].nil? && @cooks.empty?
			@message = "Aucun cook dans la BDD : initialisation nécessaire"
		elsif params[:lat].nil?
			@message = pluralize(@cooks.count, "cook") + " trouvé".pluralize(@cooks.count)
			@cooks = @cooks.sort_by { |v| v.nb_recipes }.reverse
		elsif @cooks.empty?
	      	@message = "Aucun cook n'a été trouvé autour de cette addresse..."
	    elsif
			@message = pluralize(@cooks.count, "cook") + " trouvé".pluralize(@cooks.count) + " autour de cette adresse..."
			@cooks = @cooks.sort_by { |v| v.distance }
	    end
	end

end
