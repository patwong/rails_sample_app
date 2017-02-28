require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    # post login_path, params: {sessions: {email: "not_a_real_email@email", password:"fakepassword"} }
    # post login_path, params: {sessions: {email: "", password:""} }
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?   # flash should be empty when page changes
  end

  test "login with valid information" do
    get login_path
    # assert_template 'sessions/new'
    post login_path, params: { session: {email: @user.email, password: 'password'} }
    assert_redirected_to @user
    follow_redirect!
    # assert_template "users/#{@user.id}"   # assert_template looks at the associated controller template, not url
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: {email: @user.email, password: 'password'} }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0

  end
end
