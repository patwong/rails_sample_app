require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  # section 7.3.4
  test "invalid signup information" do
    # testing if form accepts erroneous user
    # steps:
    # 1. check if signup_path works
    # 2. check if User.count stays the same before and after (assert_no_difference)
    # 3. check the form submission ('do' block)
    # 4. check if users/new re-rendered if erroneous user is added
    # 5. check if div error id+classes appear
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger'  # div class: .a .b => b inside a \\   .a.b => class is both a and b
    assert_select 'form[action="/signup"]'

    # how to check for the erroneous fields? below doesn't work
    # assert_select 'div.field_with_errors .user_name'
    # assert_select "Name can't be blank"
    # assert_select "Password is too short (minimum is 6 characters)"
  end

  # listing 7.3.3
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!

    # ch11: after this chapter the below code doesn't work since user isn't activated
    # assert_template 'users/show'
    # assert_not flash.empty?
    # assert is_logged_in?  # 8.2.5
  end
end
