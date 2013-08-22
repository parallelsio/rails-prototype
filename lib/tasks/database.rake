
namespace :database do

	desc "reset local database to default: one map, no bits"
	task :reset => :environment do

		require 'database_cleaner'

		raise "PROBABLY DONT WANT TO DO THIS PRODUCTION." if Rails.env == 'production'

	    DatabaseCleaner.strategy = :truncation	   
	    DatabaseCleaner.clean

    	seed = ENV['SEED'].blank? ? 1 : ENV['SEED']
    	Map.connection.update( "ALTER TABLE maps AUTO_INCREMENT = #{seed}" )

	    @map = Map.new(:name => 'base')
	    @map.save

	end

end