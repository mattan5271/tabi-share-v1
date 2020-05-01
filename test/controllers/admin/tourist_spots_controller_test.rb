require 'test_helper'

class Admin::TouristSpotsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_tourist_spots_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_tourist_spots_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_tourist_spots_edit_url
    assert_response :success
  end

end
