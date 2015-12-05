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

  has_attached_file :avatar, styles: { thumb: "200x200#" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :pseudo, presence: true

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

  def nb_liked?
    LikeRecipe.where(user_id: self.id).count
  end
         
end
