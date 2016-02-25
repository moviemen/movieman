source 'https://rubygems.org'

gem 'rails', '>= 5.0.0.beta3', '< 5.1'
gem 'puma'

gem 'redis'

gem 'mongoid', git: 'https://github.com/estolfo/mongoid.git', branch: 'MONGOID-4218-rails-5'

gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sidekiq_mailer'
gem 'sinatra', require: nil

gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer'
gem 'jquery-rails'
gem 'turbolinks',   '~> 5.x'

gem 'haml-rails'
gem 'twitter-bootstrap-rails'
gem 'bootstrap-material-design'

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
  gem 'listen',      '~> 3.0.5'

  gem 'railroady'
  gem 'html2haml'
  gem 'transpec'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
