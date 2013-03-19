class Parallel < ActiveRecord::Base
	
	belongs_to :cluster
	belongs_to :bit

end