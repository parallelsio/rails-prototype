class Image < Bit
	
	attr_accessible :image
	before_create :set_defaults

	mount_uploader :image, ImageUploader		# managed through CarrierWave

	def set_defaults
		return unless position_y.nil? and position_x.nil?
		self.position_y 	= 100
		self.position_x 	= 100
	end


	# to enable route helpers to work with subclasses
	# via http://stackoverflow.com/questions/4507149/best-practices-to-handle-routes-for-sti-subclasses-in-rails
	# via railscasts #394: STI
	# TODO: is using the route method better?
 	def self.model_name
    	Bit.model_name
  	end

	def cascade_position

		debugger

		@last_bit = Bit.last

      # TODO : can I use a parameter from the JS UI?
		if self.type == "Image" && @last_bit.position_y == self.position_y && @last_bit.position_x == self.position_x
			self.position_y += 20 || 0
			self.position_x += 20 || 0
		end
	end


end


