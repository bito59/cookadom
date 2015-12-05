class CreateRecipesMaterials < ActiveRecord::Migration
  def change
    create_table :recipes_materials do |t|
    	t.integer :recipe_id, :null => false
    	t.integer :material_id, :null => false
    end

	add_index :recipes_materials, [:recipe_id, :material_id], :unique => true
  end
end
