require 'capybara/rspec'
require 'cancan/matchers'
require 'support/omniauth'
require 'capybara/poltergeist'

RSpec.configure do |config|
  config.include Capybara::DSL

  Capybara.javascript_driver = :poltergeist

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:suite) do
    # This part sets the default database cleaning strategy to be transactions.
    # Transactions are very fast, and for all the tests where they do work - that is, any test where the entire test runs in the RSpec process - they are preferable.
    DatabaseCleaner.strategy = :transaction
  end

# These lines hook up database_cleaner around the beginning and end of each test,
# telling it to execute whatever cleanup strategy we selected beforehand.
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

include ActionDispatch::TestProcess
include Warden::Test::Helpers

OmniAuth.config.mock_auth[:facebook] = {
    'info' => {
        'name' => Faker::Name.name,
        'email' => Faker::Internet.email,
        'image' => '', },
    'uid' => '123545',
    'provider' => 'facebook',
    'credentials' => {'token' => 'token'}
}