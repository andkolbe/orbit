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

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[test@test.com JOHN@test.com MARY_smith-01@new.com tony.smith@example.com tony+smith@example.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should not accept invalid addresses' do
    invalid_addresses = %w[test@test,com test_at_example.com test@example. test@ex-ample.com test@exa+mple.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
