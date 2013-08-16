class Map < ActiveRecord::Base
	
	attr_accessible :name

  	has_many :clusters
  	has_many :bits

  	validates_presence_of :name
  
end
