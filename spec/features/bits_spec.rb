require 'spec_helper'
require 'ruby-debug'

describe "ShowBits" do

	it "show bits", js: true do
		map = create(:map)
		
		10.times do |count|
			bit = FactoryGirl.create(:text, :content => "yo: " + count.to_s)
		end
		
		visit root_url
		visit map_path(map)

		# TODO: fix/remove slash, refactor, -> helper
		clean_filename = "#{ Time.now.to_s.sub(/[ \:]/, '_').tr(' ', '') }_#{ map.id }.png"
		save_screenshot("#{ Rails.root }/tmp/#{ clean_filename }") 

		# expect(page).to have_content("yo:")
	end

end