require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:daniel)
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_template 'registrations/new'
    assert_difference 'User.count', 1 do
      post_via_redirect root_path, user: {
                                          first_name: "user",
                                          last_name: "example",
                                          email: "user1@test.com",
                                          password:              "password",
                                          password_confirmation: "password"
                                         }
    end
    assert_template 'static_pages/home'
  end

#  test "user gets first name and last name" do
#    get new_user_registration_path
#    assert_template 'registrations/new'
#    name = "Foo"
#    last = "Bar"
#    email = "user@example.com"
#    post_via_redirect root_path, user: { email: "user@test.com",
#                                         first_name: name,
#                                         last_name: last,
#                                         password: "password",
#                                         password_confirmation: "password"
#                                       }
#  end
end
