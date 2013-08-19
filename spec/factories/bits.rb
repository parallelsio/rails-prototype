FactoryGirl.define do

	factory :bit do
	
		# as this factory generates new bits,
		# use sequence to cascade them so they
		# dont overlap and hide each other
		sequence(:position_y) { |n| n + 50 }
		sequence(:position_x) { |n| n + 50 }

	end

end