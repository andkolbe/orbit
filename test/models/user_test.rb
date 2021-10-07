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
end
