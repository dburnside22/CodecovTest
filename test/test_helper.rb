require 'simplecov'
require 'codecov'

SimpleCov.start 'rails' do
  enable_coverage :branch
  
  # Add any custom SimpleCov filters here if needed
  # add_filter '/some/path/'
end

# Upload to Codecov if running in CI environment
if ENV['CI'] == 'true'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
