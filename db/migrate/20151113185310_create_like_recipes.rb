class CreateLikeRecipes < ActiveRecord::Migration
  def change
    create_table :like_recipes do |t|
    	t.belongs_to :user, index: true
		t.belongs_to :recipe, index: true
		t.timestamps null: false
    end
  end
end
