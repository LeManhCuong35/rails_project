require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index~" do
    get welcome_index~_url
    assert_response :success
  end
end
