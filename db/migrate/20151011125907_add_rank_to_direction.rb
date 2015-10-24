class AddRankToDirection < ActiveRecord::Migration
  def change
  	add_column :directions, :rank, :integer
  end
end
