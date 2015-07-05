class Cook < ActiveRecord::Base
	validates_uniqueness_of :user_id, :message => "The cook is already used once"
	
	belongs_to :user
	#has_many :recipes, dependent: :destroy

end
