###########################################

			# INTEGRATION

###########################################

# page.driver.debugger 		: loads browser window dom of test
# debugger 					: ruby stops mid execution

require 'spec_helper'
require 'ruby-debug'

describe "bits" do

	before(:all) do |map| 
		@map = create(:map)

		@JS_KEYCODE_N = 78
		@JS_KEYCODE_B = 66
	end

	it "displays them", js: true do

		10.times do |count|
			bit = FactoryGirl.create(:text, :content => "yo: " + count.to_s)
		end
		
		visit root_url
		visit map_path(@map)

		# TODO: fix/remove slash, refactor, -> helper
		clean_filename = "#{ Time.now.to_s.tr('-: ', '_') }_#{ @map.id }.png"
		save_screenshot("#{ Rails.root }/tmp/rspec_screenshots/#{ clean_filename }") # calls phantom.js render method

		expect(page).to have_content("yo:")
	end


	pending "shows the new text bit form", js: true do

		# debugger

		# page.execute_script %Q{$('#map').val('#{ root_path }').keydown()}
		# script = ""
		# script << %Q{ var page = require('webpage').create(); }
		# script << "page.render('4'.png)"

		# debugger
		# page.execute_script script

		# result = page.evaluate_script %Q{ var user_id = '#{ root_url }'; return user_id; }

		# result = page.evaluate_script("$('#map')")


		# keypress_script = "console.log('hi.')"

		# doesnt work, says mousetrap object is not loaded
		# keypress_script = "Mousetrap.trigger('n b');"

		# keypress_script = "var e = $.Event('keydown', { 13  ); $('#map').trigger(e);"
		# keypress_script << "var e = $.Event('keyup', { keyCode: JS_KEYCODE_B }); $('#map').trigger(e);"

		# page.evaluate("function() {
		# 	$('#map').focus();
		# });")

		# page.sendEvent('keyup', 78);


	end


	pending "shattered by pressing s key", js: true

	pending "shattered match the number of tiles chosen", js: true 

	pending "shattered, dropzone config and CarrierWave whitelists match", js: true

	pending "shattered, all whitelisted work "
	
	pending "shattered, non-unicode characters in filename"

	pending "crop, pressing c key", js: true

	pending "crop, thumb image smaller than main", js: true

end
