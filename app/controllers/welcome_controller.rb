class WelcomeController < ApplicationController
  def index
  	#cooks shown on the welcoming page
  	@cooks = Cook.order("RANDOM()").first(3)
  	#@cooks = Cook.all
  end
end
