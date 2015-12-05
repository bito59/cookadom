class CreateCooks < ActiveRecord::Migration
  def change
    create_table :cooks do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :phone_number
      t.boolean :verified_phone, default: false
      t.float :lat 
      t.float :lng
      t.string :formatted_address
      t.string :street_number
      t.string :route
      t.string :locality
      t.float :postal_code
      t.string :administrative_area_level_1
      t.string :country
      t.string :working_distance
      t.text :introduction
      t.string :gender
      t.float :price
      t.integer :language1_id
      t.integer :language2_id
      t.integer :language3_id

      t.timestamps null: false
    end
  end
end
