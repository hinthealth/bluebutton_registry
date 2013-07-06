source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongoid', '~> 3.0.0'

# For user authentication
gem 'devise'

# For user authorization
gem 'cancan'

# Administrative scaffold
gem 'rails_admin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'jquery-rails'
  gem 'uglifier', '>= 1.0.3'
end
# Haml is still required in production environments
gem 'haml-rails'
# Form helper for rendering boostrap forms
gem 'bootstrap_forms'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'travis' # For CI/CD
  gem 'heroku-headless'
end

# Capture emails sent in development mode
gem "letter_opener", :group => :development

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
