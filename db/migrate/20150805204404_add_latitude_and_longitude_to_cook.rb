class AddLatitudeAndLongitudeToCook < ActiveRecord::Migration
  def change
    add_column :cooks, :latitude, :float
    add_column :cooks, :longitude, :float
  end
end
