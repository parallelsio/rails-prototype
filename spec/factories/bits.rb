FactoryGirl.define do

	factory :bit do

		after(:create) do |bit|
			map = Map.find_or_create_by_name("test")
			bit.parallels.create( :map_id => map.id )
		end
	
		# cascade them so they
		# dont overlap and hide each other
		sequence(:position_y) { |n| n * 50 }
		sequence(:position_x) { |n| n * 50 }

		factory :image, class:Image do
			type "Image"
		end

		factory :text, class:Text do
			type "Text"
		end
	end


	factory :parallel do
		# association :bit
		# association :map
	end


	factory :map do
		name "test"
	end


end