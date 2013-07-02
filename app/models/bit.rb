# Using STI
# only the stuff that is shared among subclasses (text, image) goes here

class Bit < ActiveRecord::Base

  	has_many :parallels
  	has_many :clusters, :through => :parallels

	attr_accessible :color, :position_x, :position_y, :type



end
