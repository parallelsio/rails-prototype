
namespace :processing do

	###################################################################################
	desc "TILE AND WATERMARK"
	task :tile_watermark, :temp, :dest, :uc_product_id do |t, args|
	###################################################################################
		
		#TODO: scaling algorithm here, based on the resolution the image is displayed on the map

		temp	= args.temp
		small	= temp + "/01"
		medium	= temp + "/02"
		large	= temp + "/03"
		tile	= temp + "/04"
		convert	= "convert "
		options	= " -crop x405 +repage +adjoin -quality 70 "

		# tiling images
		puts "  * tiling..."
		files = get_files(tile, "*.jpg")
		files.each do |image_file|
			system convert + image_file + options + image_file.split(/\./).first + "_%02d.jpg"
			system "rm " + image_file
		end

		# renaming tiles for all 16 degrees
		puts "  * watermarking..."
		degrees = ["0", "23", "45", "68", "90", "113", "135", "158", "180", "203", "225", "248", "270", "293", "315", "338"]
		i = 0
		while i < 16
			# get files for each degree
			deg = "*_" + degrees[i] + "_*"
			files = Dir.glob(deg)

			# sort files to reverse order and rename, ie, 24 to 25, 23 to 24 etc....
			files.sort.reverse.each do |image_file|

				# get old name and index
				old_name = image_file.split(/_/)
				index = image_file.split(/_/).last.split(/\./).first

				# increment index/09 vs 9 issue
				new_index = (index.to_i + 1)
				if new_index < 10
					new_index = "0" + new_index.to_s
				else
					new_index = new_index.to_s
				end

				# create new name and rename
				new_name = old_name[0] + "_" + old_name[1] + "_" + old_name[2] + "_" + new_index + ".jpg"
				File.rename(image_file, new_name)

				# watermark tiles
				system "composite -gravity center ../../../public/images/watermark_405.png " + new_name + " " + new_name
			end
			i += 1
		end
		Dir.chdir("../../..")

		# move to source folder
		[small, medium, large, tile].each do |new_directory|
			system "mv " + new_directory + "/*.jpg " + temp
			Dir.delete(new_directory)
		end
	end



		###################################################################################
	desc "JPEGTRAN COMPRESSION"
	task :compress, :temp, :dest, :uc_product_id do |t, args|
	###################################################################################
		puts "  * compressing..."
		Dir.chdir(args.temp)
		files = Dir.glob("*.jpg")
		files.each do |image_file|
			system "jpegtran -copy none -optimize -perfect -outfile " + image_file + " " + image_file
		end
		Dir.chdir("../..")
	end

end
