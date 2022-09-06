require "test_helper"

class InnsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inns_index_url
    assert_response :success
  end
end
