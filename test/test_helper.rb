ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.expand_path('../../test/capybara_helper', __FILE__)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  include FactoryGirl::Syntax::Methods

  # Legacy
  def json_response
    JSON.parse(response.body)
  end

  def json
    JSON.parse(response.body).deep_symbolize_keys
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end


class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
