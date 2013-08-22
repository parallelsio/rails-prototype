
require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'


# an init. the more here the better. spork needs reboot on changes
Spork.prefork do

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  require 'capybara/rspec'
  require 'capybara/poltergeist'

  Capybara.javascript_driver = :poltergeist

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }



  RSpec.configure do |config|

    config.include Capybara::DSL, :type => :request
    config.include FactoryGirl::Syntax::Methods     # allows ".something" instead of FactoryGirl.something" 
    
    # explicitly disable older should syntax to prevent inconsistency of styles
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end

    # wipes test db on each run
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end


    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    # adds :focus functionality in rspec
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

  end

end






# runs once, each time you run specs
Spork.each_run do

  FactoryGirl.reload

end



