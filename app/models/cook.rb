class Cook < ActiveRecord::Base
	validates_uniqueness_of :user_id, :message => "The cook is already used once"
	#attr_accessible :latitude, :longitude 
	reverse_geocoded_by :latitude, :longitude
	#after_validation :reverse_geocode  
	
	belongs_to :user
	#has_many :recipes, dependent: :destroy

end
