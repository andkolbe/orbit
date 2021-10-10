require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:andrew)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "andrew@example", password: "pass", password_confirmation: "word"} }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "James Smith"
    email = "james@example.com"
    patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: ""} }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload # reloads the user's information from the database and confirm they were successfully updated
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end