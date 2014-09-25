# source 'https://rubygems.org'
source 'http://ruby.taobao.org'

ruby '2.1.2'

## Rails
gem 'rails', '4.1.5'

## DB
gem 'mysql2'

## auth
gem 'devise'
gem 'devise_invitable'
gem 'pundit'

## views
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-sass'
gem 'haml-rails'
gem 'high_voltage'
gem 'simple_form'
# admin
gem 'upmin-admin'

## doc generator
gem 'sdoc', '~> 0.4.0',          group: :doc

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
end

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_21]
  # cap deploy
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm', '~> 0.1.1'

  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end


group :production do
  gem 'unicorn'
end

