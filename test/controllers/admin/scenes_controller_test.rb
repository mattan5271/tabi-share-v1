require 'test_helper'

class Admin::ScenesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_scenes_new_url
    assert_response :success
  end

  test "should get index" do
    get admin_scenes_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_scenes_edit_url
    assert_response :success
  end

end
