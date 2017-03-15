require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'

    # why is count 2? because of root path is linked in logo and nav menu element
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path    # exercise 5.4 extra :)

    # exercise 5.3.4
    get contact_path
    assert_select "title", full_title("Contact")
    # end exercise

    # exercise 5.4
    get signup_path
    assert_select "title", full_title("Sign up")
    # end exercise
  end

  # exercise 10.3.1.1
  test "checking all links before and after login" do
    get root_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    assert_select "a[href=?]", users_path, count: 0
    log_in_as(@user)
    assert_redirected_to @user  # user_path(@user) # rails magic doesn't need user_path(@user)
    follow_redirect!            # always need to include follow_redirect! when there's redirect
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", users_path
  end

end
