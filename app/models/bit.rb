# Using STI
# only what is shared among subclasses (text, image) goes here

class Bit < ActiveRecord::Base

  	has_many :parallels 
  	has_many :map, :through => :parallels, :dependent => :destroy

	attr_accessible :color, :position_x, :position_y, :type, :created_at

	validates_presence_of :position_x, :position_y, :type
	
	validates_numericality_of :position_x, 
		:only_integer => true, 
		:greater_than_or_equal_to => 0, 
		:allow_nil => false,
		:message => 'position_x is negative (off the map)'
	
	validates_numericality_of :position_y, 
		:only_integer => true, 
		:greater_than_or_equal_to => 0, 
		:allow_nil => false,
		:message => 'position_y is negative (off the map)'
end
