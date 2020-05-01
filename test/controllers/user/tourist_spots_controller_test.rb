require 'test_helper'

class User::TouristSpotsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_tourist_spots_new_url
    assert_response :success
  end

  test "should get index" do
    get user_tourist_spots_index_url
    assert_response :success
  end

  test "should get show" do
    get user_tourist_spots_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_tourist_spots_edit_url
    assert_response :success
  end

end
