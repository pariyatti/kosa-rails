require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    cleanup
  end

  teardown do
    cleanup
  end

  test "create a new user" do
    this_user = stub_user
    assert_difference('User.count') do
      post users_url(as: this_user),
        params: { user: { 
          email: "foo@baz.com",
          password: "secret"
        } }
    end

    new_user = User.find_by(email: "foo@baz.com")
    assert new_user.admin?
    assert_redirected_to user_url(new_user)
  end

  test "user cannot delete herself" do

  end

  def cleanup
    User.all.each { |u| u.destroy }
  end
end
