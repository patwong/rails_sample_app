require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # get users_new_path
    get signup_path
    assert_response :success
  end

end
