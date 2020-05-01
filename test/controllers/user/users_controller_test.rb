require 'test_helper'

class User::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_users_edit_url
    assert_response :success
  end

  test "should get following" do
    get user_users_following_url
    assert_response :success
  end

  test "should get follower" do
    get user_users_follower_url
    assert_response :success
  end

end
