class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :description
      t.integer :cook_stars
      t.integer :cook_id

      t.timestamps null: false
    end
  end
end
