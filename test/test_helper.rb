ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "vcr"
require "rails/test_help"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = false
  config.ignore_request { ENV["DISABLE_VCR"] }
  config.ignore_localhost = true
  config.default_cassette_options = {
    record: :new_episodes
  }
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
