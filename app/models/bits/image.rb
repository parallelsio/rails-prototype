class Image < Bit

	before_save :make_as_image

	def make_as_image
		self.image = "stub.jpg"
	    self.type = "Image"
	end





end
