require 'spec_helper'
require 'ruby-debug'


describe "ShowBits" do

	it "show bits" do
		map = FactoryGirl.create(:map)
		visit "/maps/1"
	end
end