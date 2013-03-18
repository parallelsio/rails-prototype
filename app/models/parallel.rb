class Parallel < ActiveRecord::Base
	
	belongs_to :cluster
	has_many :bits

end