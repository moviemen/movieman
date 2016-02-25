source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta2', '< 5.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Action Cable dependencies for the Redis adapter
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'haml-rails'
gem 'twitter-bootstrap-rails'
gem 'bootstrap-material-design'
gem 'therubyracer'

gem 'activemodel-serializers-xml' # draper spike https://github.com/drapergem/draper/issues/697
gem 'draper', github: 'audionerd/draper', branch: 'rails5'

gem 'sidekiq'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
   gem 'byebug'
  gem 'rspec-rails'
  gem 'rspec-activejob'
  gem 'rspec-sidekiq'
  gem 'rspec-retry'
  gem 'capybara'
  gem 'site_prism'
  gem 'parallel_tests'
  gem 'pry'
end

group :test do
  gem 'database_cleaner'
  gem 'phantomjs'
  gem 'poltergeist'
  gem 'timecop'
  gem 'webmock'
  gem 'vcr'
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'spring'
  gem 'railroady'
  gem 'html2haml'
  gem 'transpec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
