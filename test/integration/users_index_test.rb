require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @mrunactivated = users(:mister_unactivated)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    # first_page_of_users = User.where(activated: true).paginate(page:1)
    first_page_of_users = User.paginate(page:1)
    first_page_of_users.each do |user|
      # ex 11.3.3.3 - see notes for help and explanation
      if user.activated?
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      else
        assert_select 'a[href=?]', user_path(user), text: user.name, count: 0
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  # exercise 11.3.3.3
  test "index with unactivated users" do
    log_in_as(@non_admin)
    get user_path(@mrunactivated)
    follow_redirect!
    assert_template 'static_pages/home'
  end

end
