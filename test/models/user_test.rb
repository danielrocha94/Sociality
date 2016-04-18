require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user= User.new(first_name: "User", last_name: "Example", email: "user@example.com")
  end

  test "name should not be blank" do
    @user.first_name = ""
    @user.last_name = ""
    assert_not @user.valid?
  end


end
