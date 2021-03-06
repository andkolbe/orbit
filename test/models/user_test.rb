require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password")
  end

  test "should be valid"  do
    assert @user.valid? # will return true or false whether the user is valid or not
  end

  test "name should be present" do
    @user.name = "             "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name cannot be too long" do
    @user.name = "a" * 61
    assert_not @user.valid?
  end

  test "email cannot be too long" do
    @user.email = "a" * 255 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[tony@example.com JOHN@test.com MARY_smith-01@new.com tony.smith@example.com tony+smith@example.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should not accept invalid email addresses" do
    invalid_addresses = %w[test@example,com test_at_example.com test@example. test@ex+ample.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup # dup duplicates a user with the same attributes
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (cannot be blank)" do
    @user.password = @user.password_confirmation = " "  * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "p" * 5
    assert_not @user.valid?
  end

  test "associated snapshots should be destroyed" do
    @user.save
    @user.snapshots.create!(content: "Great job")
    assert_difference 'Snapshot.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    andrew = users(:andrew)
    odin = users(:odin)
    assert_not andrew.following?(odin)
    andrew.follow(odin)
    assert andrew.following?(odin)
    assert odin.followers.include?(andrew)
    andrew.unfollow(odin)
    assert_not andrew.following?(odin)
  end
end
