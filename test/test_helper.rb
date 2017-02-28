ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper
  # Add more helper methods to be used by all tests here...

  # Section 8.25
  # since ApplicationHelper is included, add to app/helpers/application_helper.rb instead
  # def is_logged_in?
  #   !session[:user_id].nil?
  # end
end
