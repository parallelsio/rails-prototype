FactoryGirl.define do

	factory :map do
		name "test"
	end

	factory :cluster do
		
		after_build do |cluster|
			FactoryGirl.create()
		end
	end


	factory :bit do
		text "hello world!"
	end


end