class Parallel < ActiveRecord::Base
	
	attr_accessible :map_id, :bit_id
	belongs_to :map
	belongs_to :bit

end