class DirectionsController < ApplicationController

before_action :find_direction, only: [:update, :edit, :destroy]

	def create
	    rank = Direction.where(recipe_id: direction_params[:recipe_id]).count + 1
	    @direction = Direction.new(direction_params.merge(rank: rank))
	    if @direction.save
		    @directions = Direction.where(recipe_id: direction_params[:recipe_id]).order("rank ASC")
			get_rank_list()
		    respond_to do |format|
				format.json { head :no_content }
		    	format.js { render :layout => false, directions: @directions, rank_list: @rank_list }
			end
		end
	end

	def update
		#rank = Direction.where(recipe_id: direction_params[recipe_id]).count + 1
		#direction_params.merge(rank: rank)
		respond_to do |format|
	      if @direction.update(direction_params)
	        #format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
	        format.json { head :no_content }
	      else
	        #format.html { render action: 'edit' }
	        format.json { render json: @direction.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
		recipe_id = @direction.recipe_id
		rank = @direction.rank
		if @direction.destroy
			@directions = Direction.where(recipe_id: recipe_id).order("rank ASC")
			@directions.each do |direction|
				if direction.rank > rank
					Direction.find(direction.id).decrement(:rank, 1).save
					direction.decrement(:rank, 1)
				end
			end
			get_rank_list()
		    respond_to do |format|
				format.html { redirect_to ponies_url }
				format.json { head :no_content }
				format.js { render :layout => false }
		    end
		end
	end

	private

	def direction_params
	   params.require(:direction).permit(:step, :recipe_id, :rank)
	end

	def find_direction
		@direction = Direction.find(params[:id])
	end

end