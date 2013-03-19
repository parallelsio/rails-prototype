class Bit < ActiveRecord::Base

	belongs_to :map
  	has_many :parallels

	attr_accessible :color, :content, :image, :location_x, :location_y, :type

end
