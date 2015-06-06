class CreateCooks < ActiveRecord::Migration
  def change
    create_table :cooks do |t|
      t.integer :user_id
      t.string :name
      t.string :postal_code
      t.text :introduction

      t.timestamps null: false
    end
  end
end
