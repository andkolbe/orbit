require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:andrew) # we created this user in test/fixtures/users.yml
  end

  test 'login with valid information' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect! # redirect to the correct page
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0 # count: 0 means zero links match the current pattern. login should no longer be displayed
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
