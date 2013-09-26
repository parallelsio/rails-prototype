source 'http://rubygems.org'
# http://docs.rubygems.org/read/chapter/16

ruby '1.9.3'

gem 'rails', '3.2.13'

gem 'figaro'                                        # access env vars in app

gem 'thin'                                          # local server, allows for hiding assets lines in log
gem 'haml'
gem 'haml-rails'					                          # auto generate haml templates instead of erb
gem 'sass-rails',   '~> 3.2.4'
gem 'carrierwave'                                   # file uploading glue between rails and cloud storage
gem 'fog', '~> 1.3.1'                               # cloud storage wrapper

gem 'jquery-rails', '2.3.0'                         # using version number to solve http://stackoverflow.com/questions/16905633/cant-install-active-admin-for-ruby-on-rails-sprocketsfilenotfound

gem 'image_sorcery'                                 # light, wrapper around imagemagick, create /tmp/image_sorcery manual first time


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end


group :development  do
  gem 'debugger'
  gem 'better_errors'                             # only in this env! we dont want to show errors to users on production
  gem 'binding_of_caller'                         # enable the REPL and local/instance variable inspection.
end

group :test do
  gem 'capybara'                                  # acceptance test framework, simulating real user interaction
  gem 'database_cleaner'
  gem 'guard-rspec'                               # watches test files, auto runs modified tests
  gem 'spork'                                     # reduces load up time of rspec
  gem 'guard-spork'                               # watches any changes to spork
  gem 'turn', '~> 0.8.3', :require => false
  gem 'launchy'                                   # launches browser when capybara asks it to
  gem 'poltergeist',  :git => 'git://github.com/jonleighton/poltergeist.git'     # driver for Capybara. allows running Capybara tests on a headless WebKit browser, provided by PhantomJS
end

group :development, :test  do
  gem 'mysql2'
  gem 'foreman'
  gem 'quiet_assets'                              # hiding assets lines in log 
  gem 'rmagick'                                   # ruby wrapper for imagemagick, an image manipulation lib
  gem 'fuubar'                                    # progressbar and nice formatting for rspec output

  gem 'rspec-rails'                               
  gem 'factory_girl_rails'                        # creates data objects for tests, replaces rails default test::unit
  gem 'jasminerice'                               # testing js
end



group :production do
  gem 'pg'
  gem 'rmagick', :require => 'RMagick'            # heroku already has it installed
end
