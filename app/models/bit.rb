class Bit < ActiveRecord::Base

	# belongs_to :map 
  	has_many :parallels
  	has_many :clusters, :through => :parallels

	attr_accessible :color, :content, :image, :location_x, :location_y, :type

end
