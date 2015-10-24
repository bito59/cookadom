class Direction < ActiveRecord::Base
  belongs_to :recipe
  attr_accessor :source

end
