class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :cook, dependent: :destroy

  has_many :comments
  has_many :users, through: :comments
  
  has_many :like_recipes, dependent: :destroy
  has_many :recipes, through: :like_recipes

  has_attached_file :avatar, 
    styles: { thumb: "200x200#" }, default_url: "avatar/default.jpg",
    :path => "/users/:id/avatar/:filename"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :pseudo, presence: { message: "Pseudo is required" } , uniqueness: { message: "Pseudo already used" } 
  validates :email, presence: { message: "Email is required" } , uniqueness: { message: "Email already used" } 

  attr_accessor :nb_liked
  #before_save :generate_new_friendly_id

  # friendly_ID to show the pseudo of users instead of IDs
  extend FriendlyId
  friendly_id :pseudo, use: :slugged


  # creates a new heart row with post_id and user_id
  def like_recipe!(recipe)
    self.like_recipes.create!(recipe_id: recipe.id)
  end

  # destroys a heart with matching post_id and user_id
  def unlike_recipe!(recipe)
    like_recipe = self.like_recipes.find_by_recipe_id(recipe.id)
    like_recipe.destroy!
  end

  # returns true of false if a post is hearted by user
  def like_recipe?(recipe)
    self.like_recipes.find_by_recipe_id(recipe.id)
  end

  #def nb_liked?
    #LikeRecipe.where(user_id: self.id).count
  #end

  def nb_liked?
    self.nb_liked = LikeRecipe.where(user_id: self.id).count
  end
         
end
