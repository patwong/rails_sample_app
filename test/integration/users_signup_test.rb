require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    # testing if form accepts erroneous user
    # steps:
    # 1. check if signup_path works
    # 2. check if User.count stays the same before and after (assert_no_difference)
    # 3. check the form submission ('do' block)
    # 4. check if users/new re-rendered if erroneous user is added
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end
end
