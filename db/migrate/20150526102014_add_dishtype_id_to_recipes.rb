class AddDishtypeIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :dishtype_id, :integer
  end
end
