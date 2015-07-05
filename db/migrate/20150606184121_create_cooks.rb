class CreateCooks < ActiveRecord::Migration
  def change
    create_table :cooks do |t|
      t.references :user, index: true
      t.string :name
      t.string :postal_code
      t.string :working_distance
      t.text :introduction

      t.timestamps null: false
    end
  end
end
