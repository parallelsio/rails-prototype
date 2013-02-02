source 'http://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.11'

gem 'haml'
gem 'sass-rails',   '~> 3.2.4'
gem 'paperclip', '~> 3.4.0'
gem 'aws-sdk', '~> 1.6.0'

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
end

group :production do
  gem 'pg'
  gem 'thin'
end

gem 'jquery-rails'


group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
