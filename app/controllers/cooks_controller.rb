class CooksController < ApplicationController

	def index
		@cooks = User.all
		
	end




	private

	def find_cooks
		@cooks = Cook.find(params[:id])
	end

end
