FactoryGirl.define do

	factory :cluster do
		after_build do |cluster|
			FactoryGirl.create()
		end
	end

end