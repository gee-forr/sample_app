source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'gravatar_image_tag'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'rspec-rails'
  gem 'guard-pow'
  gem 'pry-rails'
  gem 'annotate'
end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'webrat'
  gem 'growl'
  gem 'ruby_gntp'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'spork'
  gem 'guard-spork'
end

