require 'spec_helper' 

describe Bit do 


	context "is valid" do
		valid_bit = Bit.new(
			position_y: 300,
			position_x: 200,
			type: 'Text'
			)
		it "with position_x, position_y, type" do
			expect(valid_bit).to be_valid 
		end
	end


	context "is invalid" do
		it "with a nil type" do
			expect(Bit.new(type: nil)).to have(1).errors_on(:type)
		end

		# TODO: why isnt satisfy working ?
		# it "with a type, something other than Image or Text" do
		# 	expect(Bit.new(type: nil)).to satisfy { |v| v == 'Image' || v == 'Text' }
		# end


		context "with a negative position" do
			negative_position_bit = Bit.new(
				position_y: -120,
				position_x: -120,
				type: 'Text'
				)

			it "position_y" do
				expect(negative_position_bit).to have(1).errors_on(:position_y)
			end

			it "position_x" do
				expect(negative_position_bit).to have(1).errors_on(:position_x)
			end
		end


		context "with a nil position" do
			no_position_bit = Bit.new(
				position_y: nil,
				position_x: nil,
				type: 'Text'
				)

			it "position_y" do
				expect(no_position_bit).to have(2).errors_on(:position_y)
			end

			it "position_x" do
				expect(no_position_bit).to have(2).errors_on(:position_x)
			end
		end


	end








end 