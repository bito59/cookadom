class AddSlugToCooks < ActiveRecord::Migration
  def change
  	add_column :cooks, :slug, :string
  end
end
