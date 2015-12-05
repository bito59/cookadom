class CreateRecipesIngredients < ActiveRecord::Migration
  def change
    create_table :recipes_ingredients, :id => false do |t|
    	t.integer :recipe_id, :null => false
    	t.integer :ingredient_id, :null => false
    end

	add_index :recipes_ingredients, [:recipe_id, :ingredient_id], :unique => true

  end
end
