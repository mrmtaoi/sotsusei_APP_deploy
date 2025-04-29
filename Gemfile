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

group :development do
  gem 'whenever', require: false
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

group :development do
  gem 'letter_opener_web'
end

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
