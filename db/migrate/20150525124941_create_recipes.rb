class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
    	  t.belongs_to :cook, index: true
        t.string :title
      	t.string :intro
      	t.text :description
      	t.integer :dishtype_id
      	t.integer :duration
		    t.attachment :image
		    t.float :stars
		
      	t.timestamps null: false

    end
  end
end
