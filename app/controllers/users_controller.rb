class UsersController < ApplicationController

	def index
		@user = User.find_by(id: current_user)
	end

end
