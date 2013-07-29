# Using STI
# only the stuff that is shared among subclasses (text, image) goes here

class Bit < ActiveRecord::Base

  	has_many :parallels
  	has_many :clusters, :through => :parallels, :dependent => :destroy

	attr_accessible :color, :position_x, :position_y, :type

	after_initialize :defaults


	def defaults
		self.position_y = 100
		self.position_x = 100
	end


	def cascade_position
		@last_bit = Bit.last

      # TODO : can I use a parameter from the JS UI?
		if self.type == "Image" && @last_bit.position_y == self.position_y && @last_bit.position_x == self.position_x
			self.position_y += 20
			self.position_x += 20
		end
	end



end
