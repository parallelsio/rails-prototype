
namespace :db do

	desc "clear local database, initialize with one map, no bits"
	task :prep => :environment do

		require 'database_cleaner'

		raise "PROBABLY DONT WANT TO DO THIS PRODUCTION." if Rails.env == 'production'

	    DatabaseCleaner.strategy = :truncation	   
	    DatabaseCleaner.clean

    	seed = ENV['SEED'].blank? ? 1 : ENV['SEED']
    	Map.connection.update( "ALTER TABLE maps AUTO_INCREMENT = #{seed}" )

	    @map = Map.new(:name => 'base')
	    @map.save

	    puts 'Note: Amazon S3 images not deleted through this process. Delete manually.'
	end

end