# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'nokogiri', '~> 1.10', '>= 1.10.9'
gem 'pry', '~> 0.12.2'
gem 'redis', '~> 4.1', '>= 4.1.3'
gem 'redis-rails', '~> 5.0', '>= 5.0.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  gem 'rspec-rails', '~> 3.9', '>= 3.9.1'
  gem 'rubocop', '~> 0.80.1'
  gem 'vcr', '~> 5.1'
  gem 'webmock', '~> 3.8', '>= 3.8.3'
end

group :test do
  gem 'database_cleaner', '~> 1.8', '>= 1.8.3'
  gem 'faker', '~> 2.10', '>= 2.10.2'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3'
  gem 'mock_redis', '~> 0.22.0'
  gem 'shoulda-matchers', '~> 4.3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
