ENV['RAILS_ENV'] ||= 'test'
ENV['DEVISE_SECRET_KEY'] ||= 'secretz'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.include FactoryGirl::Syntax::Methods
end

