class Cook < ActiveRecord::Base

	attr_accessor :distance, :nb_recipes, :nb_avis, :nb_stars, :in_range, :nb_languages

	belongs_to :user
	has_many :recipes, dependent: :destroy	

	validates_uniqueness_of :user_id, :message => "The cook is already used once"
	validates_presence_of :title, :lat, :lng, :phone_number,
			:formatted_address, :locality, 
			:postal_code, :administrative_area_level_1, :country,
			:working_distance, :introduction, :gender

	reverse_geocoded_by :lat, :lng


	def rating
		self.nb_avis = Comment.where(:cook_id == self.id).count
		self.nb_stars = 1
	end

	def nb_languages
		p = [self.language1_id, self.language2_id, self.language3_id]
		self.nb_languages = p.compact.count
	end

	def near?
		if self.distance.to_f < self.working_distance.to_f
			self.in_range = "OK"
		else
			self.in_range = "QUESTION"
		end
	end

end
