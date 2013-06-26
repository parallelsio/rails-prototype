class Text < Bit
	
	attr_accessible :content
	before_save :defaults

	def defaults
	    self.type = "Text"
	    self.color = "yellow"
	end

	# to enable routes to work with subclasses
	# http://stackoverflow.com/questions/4507149/best-practices-to-handle-routes-for-sti-subclasses-in-rails
 	def self.model_name
    	Bit.model_name
  	end

end
