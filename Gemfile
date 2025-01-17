source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.3.1'
# Use Puma as the app server
gem 'puma', '~> 4.3.5'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'pg'

gem 'nokogiri'
gem 'redis'
gem 'faraday', '~> 1.0.1'
gem 'virtus'
gem 'memoist'
gem "actionpack-page_caching", "~> 1.2.1"
gem 'rollbar'
gem 'ruby-rtf'
gem 'colorize'
gem 'ruby-mp3info'
gem 'mp3info'
gem 'levenshtein'
gem 'diffy'
gem 'dry-struct', '~> 1.0.0'
gem 'redis-mutex'
gem 'rack-attack'
gem 'aws-sdk-s3', '~> 1'

group :test do
  gem 'rspec-rails'
  gem 'timecop'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem "guard"
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'webmock'
  gem 'vcr'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
