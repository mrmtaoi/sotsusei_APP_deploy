source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.8", ">= 7.0.8.7"

gem "sprockets-rails"

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem 'nokogiri', '~> 1.10'
gem 'ransack'
gem 'rakuten_web_service'
gem 'dotenv-rails'
gem 'json'
gem 'rake'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'rubocop', require: false
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false
gem 'faker'
gem 'whenever', require: false

group :development do
  gem 'whenever', require: false
  gem 'letter_opener_web'
  gem "web-console"
  gem 'spring', '4.3.0'
  gem 'spring-commands-rspec'
end

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem 'sassc'

gem 'sassc-rails'

gem 'sendgrid-ruby', '~> 6.0'

gem 'bootstrap', '~> 5.3.3'
gem 'jquery-rails'

gem "bcrypt"

gem 'rails-i18n', '~> 7.0.0'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'rails-controller-testing'
end
