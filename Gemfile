source 'http://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.11'
gem 'thin'                # local server, allows for hiding assets lines in log
gem 'haml'
gem 'haml-rails'					# auto generate haml templates instead of erb
gem 'sass-rails',   '~> 3.2.4'
gem 'carrierwave'         # file uploading glue between rails and cloud storage
gem 'fog', '~> 1.12.1'    # cloud storage wrapper
gem 'figaro'              # access env vars


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end


group :development, :test  do
  gem 'mysql2'
  gem 'foreman'
  gem 'debugger'
  gem 'quiet_assets'    # hiding assets lines in log 

end

group :production do
  gem 'pg'
end

gem 'jquery-rails', '2.3.0'   # using version number to solve http://stackoverflow.com/questions/16905633/cant-install-active-admin-for-ruby-on-rails-sprocketsfilenotfound

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
