class AddTempsToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :duration, :integer
    add_column :recipes, :dish_type, :string
    add_column :recipes, :stars, :integer
  end
end
