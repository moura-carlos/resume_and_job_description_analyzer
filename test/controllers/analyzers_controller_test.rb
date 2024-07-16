require "test_helper"

class AnalyzersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get analyzers_new_url
    assert_response :success
  end

  test "should get create" do
    get analyzers_create_url
    assert_response :success
  end
end
