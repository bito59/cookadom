class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.belongs_to :recipe, index: true
      t.integer :rank
      t.text :step

      t.timestamps null: false
    end
  end
end
