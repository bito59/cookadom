class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  	before_filter :configure_permitted_parameters, if: :devise_controller?
  	protect_from_forgery with: :exception

  def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :gender, :pseudo, :email, :password, :password_confirmation, :current_password) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :gender, :pseudo, :email, :password, :password_confirmation, :current_password) }
	end

	def get_rank_list()
  		source = []
  		@directions.count.times do |n|
			source << {value: (n+1), text: (n+1).to_s}
		end
		@rank_list =  source
  end

  def get_dishtype_list()
      source = []
      Dishtype.all.each do |n|
      source << {value: n.id, text: n.name}
    end
    @dishtype_list =  source
  end

  def count_cook_stars()
    if Comment.where(:cook_id == cook.id).count > 0
            nb_stars = 0
          else
            nb_stars = Comment.where(:cook_id == cook.id).average(:cook_stars)
    end
  end

  def search_cooks(coordinates)
    @adress = params[:formatted_address]
    @proximite = "à proximité"
    @cooks = Cook.all
    @cooks.each do |cook|
      cook.distance = cook.distance_from(coordinates).round(1).to_s
      if cook.distance.to_f < cook.working_distance.to_f + 10
        cook.rating
        cook.near?
      else
        @cooks.delete(cook)
      end
    end
  end

end
