require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'

    # why is count 2? because of root path is linked in logo and nav menu element
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    # exercise 5.3.4
    get contact_path
    assert_select "title", full_title("Contact")
    # end exercise
  end
end
