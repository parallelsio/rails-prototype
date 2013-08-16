require 'spec_helper'
require 'ruby-debug'


describe "ShowBits" do


	# set up one cluster in a map
	map = Map.create(name: 'test' )
	cluster = map.clusters.build()
	map.save
	
	bit = Bit.new(
			position_y: 120,
			position_x: 120,
			type: 'Text'
			)

	parallel = bit.parallels.build
    parallel.bind_to_closest_cluster

    bit.save




	it "show bits" do
		map = FactoryGirl.create(:map)
		# bit = FactoryGirl.create(:bit)
		visit root_url
	end


end