source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.4', '>= 5.2.4.3'

# gem 'sqlite3'

gem 'puma', '~> 3.11'

gem 'sass-rails', '~> 5.0'

gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'

gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'bootstrap', '~> 4.1.1'

gem 'jquery-rails'

gem 'kaminari'

gem 'bootstrap4-kaminari-views'

gem 'dotenv-rails'

gem 'gon'

gem 'font-awesome-sass', '~> 5.4.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'sqlite3'
end

group :development do
  gem 'web-console', '>= 3.3.0'

  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'

  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'rubocop', require: false
end

group :test do
  gem 'capybara', '>= 2.15'

  gem 'selenium-webdriver'

  gem 'chromedriver-helper'
end

group :production do
  gem 'pg', '>= 0.18', '< 2.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
