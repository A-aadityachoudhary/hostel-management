require "test_helper"

class AllocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get allocations_create_url
    assert_response :success
  end
end
