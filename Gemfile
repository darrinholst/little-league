source 'http://rubygems.org'

ruby "1.9.3"

gem 'rails', '3.2.16'
gem 'chronic'
gem 'devise'
gem 'git-version'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'ri_cal'
gem 'safe_yaml'
gem 'twitter-bootstrap-rails'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'execjs'
  gem 'therubyracer'
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'spork', :git => 'https://github.com/sporkrb/spork.git'
  gem 'fixjour'
  gem 'heroku'
  gem 'taps'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
end

group :production do
  gem 'thin'
  gem 'pg'
  gem 'newrelic_rpm'
end
