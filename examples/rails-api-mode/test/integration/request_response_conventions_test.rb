require "test_helper"

class RequestResponseConventionsTest < ActionDispatch::IntegrationTest
  test "returns a consistent profile envelope" do
    get "/v1/profile"

    assert_response :success
    assert_equal "profile", response.parsed_body.dig("data", "type")
    assert response.parsed_body.dig("meta", "request_id").present?
  end

  test "updates a profile with snake_case fields" do
    patch "/v1/profile", params: { display_name: "Patched Example" }, as: :json

    assert_response :success
    assert_equal "Patched Example", response.parsed_body.dig("data", "attributes", "display_name")
    assert response.parsed_body.dig("data", "attributes", "updated_at").present?
  end
end
