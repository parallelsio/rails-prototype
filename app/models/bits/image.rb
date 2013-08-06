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

  	# when multiple images are drag and dropped onto canvas
  	# stagger them so they are easily seen and accessed
	def cascade_position

		num_pixels_to_shift_by = 20

		@last_bit = Bit.last

		# if the bit to be added now is overlapping with the last bit's position
		# this one needs to be shifted
		# or, if this bit is 
		if self.type == "Image" && 
			((@last_bit.position_y == self.position_y && @last_bit.position_x == self.position_x) ||
			(	@last_bit.position_y == (self.position_y + num_pixels_to_shift_by) && 
				(@last_bit.position_x == self.position_x + num_pixels_to_shift_by) ))

			# avoid nil errors by adding 0 when needed
			self.position_y += num_pixels_to_shift_by || 0
			self.position_x += num_pixels_to_shift_by || 0
		end


	end


end


