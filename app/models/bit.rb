class Bit < ActiveRecord::Base

	 has_many :parallels
  	 has_many :clusters, through: :parallels

	attr_accessible :color, :content, :image, :location_x, :location_y, :type

end
