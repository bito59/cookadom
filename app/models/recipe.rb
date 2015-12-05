class Recipe < ActiveRecord::Base
	
	attr_accessor :distance, :in_range

	belongs_to :cook
	belongs_to :dishtype

	has_many :ingredients
	has_many :directions
	has_many :like_recipes, dependent: :destroy
	has_many :users, through: :like_recipes

	has_attached_file :image, styles: { medium: "300x300#", thumb: "200x200#" }

	validates_presence_of :cook_id, :stars, :title, :intro, :description, :duration, :stars
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	accepts_nested_attributes_for 	:ingredients, 
									:reject_if => proc { |attributes| attributes['name'].blank? }, 
									:allow_destroy => true
	accepts_nested_attributes_for 	:directions, 
									:reject_if => :all_blank, 
									:allow_destroy => true

end
