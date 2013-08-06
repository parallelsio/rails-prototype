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

		# ie, if 4 bits are dragged, and offset is 20 pixels
		# to calc the 4th bit offset, look for this pattern
		# 1st bit   : 510 : 301
		# 2nd		: 530 : 321
		# 3rd		: 550 : 341

  	# tried doing on JS side:
  	# http://stackoverflow.com/questions/16998420/dropzone-js-how-to-do-something-after-all-files-are-uploaded
  	# but order is unpredictable, so for now, doing server side here
	def cascade_position

		num_pixels_to_shift_by = 20

		# lets find the last bit, only if its an image and create recently
		# to prevent accidental overlap with other bits, we also use time to restrict the 
		# bits scanned only within the last few minutes. 
		last_bit = Bit.where("created_at > :created_at AND type= :type", { created_at: 2.minutes.ago, type: "Image" }  ).last

		if last_bit.present?

			y_difference = last_bit.position_y - self.position_y
			x_difference = last_bit.position_x - self.position_x

			y_mod = y_difference % num_pixels_to_shift_by
			x_mod = x_difference % num_pixels_to_shift_by

			y_multiple = y_difference / num_pixels_to_shift_by
			x_multiple = x_difference / num_pixels_to_shift_by

			# if both are 0, the last bit has been cascaded
			if y_mod == 0 && x_mod == 0

				# how many times over we need to offset, from the original position
				# assuming the difference is the same, as the offset should be in sync
				if y_difference == x_difference

					# avoid nil errors by adding 0 when needed
					self.position_y += ( num_pixels_to_shift_by * x_multiple ) + num_pixels_to_shift_by || 0
					self.position_x += ( num_pixels_to_shift_by * y_multiple ) + num_pixels_to_shift_by || 0
				end
			end
		end
	end


end


