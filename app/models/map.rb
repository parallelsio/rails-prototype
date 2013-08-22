class Map < ActiveRecord::Base
	
	attr_accessible :name

	has_many :parallels
	has_many :bits, :through => :parallels

  	validates_presence_of :name
  
end
