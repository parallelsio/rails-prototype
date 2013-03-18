class Bit < ActiveRecord::Base

	belongs_to :map
  	belongs_to :parallels

	attr_accessible :color, :content, :image, :location_x, :location_y, :type

end
