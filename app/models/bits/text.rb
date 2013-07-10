class Text < Bit
	
	attr_accessible :content
	before_save :defaults

	def defaults
	    self.color = "yellow"
	end

	# to enable routes to work with subclasses
	# via http://stackoverflow.com/questions/4507149/best-practices-to-handle-routes-for-sti-subclasses-in-rails
	# via railscasts #394: STI
	# TODO: is using the route method better?
 	def self.model_name
    	Bit.model_name
  	end

end
