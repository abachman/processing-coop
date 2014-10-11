source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Use postgres as the database for Active Record
gem 'pg'

# require early so subsequent gems have access to ENV
gem 'dotenv-rails', group: [:development, :test]

# for dotenv support in Capistrano deployment tasks, patched to backport 0.11.0
# features to 0.7.0, which is required by dotenv-rails.
gem 'dotenv-deployment'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# group :doc do
#   # bundle exec rake doc:rails generates the API under doc/api.
#   gem 'sdoc', require: false
# end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

# # just use Devise
# gem 'devise'

# Use unicorn as the app server
gem 'unicorn'
gem 'foreman'
gem 'em-websocket'

# # Redis for communications
# gem 'hiredis'
# gem 'redis', '~> 3.0.6'
# gem 'em-hiredis'

# Use Capistrano for deployment
group :development do
#  gem 'capistrano', '~> 3.0.0'
#  gem 'capistrano-bundler', '~> 1.0.0'
#  gem 'capistrano-rails', '~> 1.0.0'
#  gem 'capistrano-rvm'

  # launching a restarting websocket server in development
  gem 'rb-fsevent'
  gem 'rerun'

  gem 'em-websocket-client'
end

# Use debugger
# gem 'debugger', group: [:development, :test]
