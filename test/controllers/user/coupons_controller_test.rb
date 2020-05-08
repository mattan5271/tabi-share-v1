require 'test_helper'

class User::CouponsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_coupons_index_url
    assert_response :success
  end

end
