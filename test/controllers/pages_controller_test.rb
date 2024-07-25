require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get casual" do
    get pages_casual_url
    assert_response :success
  end

  test "should get sports" do
    get pages_sports_url
    assert_response :success
  end
end
