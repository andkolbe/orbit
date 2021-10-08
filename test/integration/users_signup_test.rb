require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do # assert no difference in the amount of Users we have in the database, because one should not have been added
      post users_path, params: { user: { name: " ", email: "andrew@example", password: "pass", password_confirmation: "word" } }
    end

    assert_template 'users/new'
    
  end
end
