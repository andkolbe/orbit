require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@test.com")
  end

  test 'should be valid'  do
    assert @user.valid? # will return true or false whether the user is valid or not
  end

  test 'name should be present' do
    @user.name = '             '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name cannot be too long' do
    @user.name = 'a' * 61
    assert_not @user.valid?
  end

  test 'email cannot be too long' do
    @user.email = 'a' * 255 + '@example.com'
    assert_not @user.valid?
  end
end
