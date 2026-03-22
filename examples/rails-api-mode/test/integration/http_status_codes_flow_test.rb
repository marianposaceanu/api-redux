require "test_helper"

class HttpStatusCodesFlowTest < ActionDispatch::IntegrationTest
  test "creates a widget" do
    post "/widgets", params: { name: "red-widget", color: "red" }, as: :json

    assert_response :created
    assert_equal "/widgets/wid_123", response.headers["Location"]
    assert_equal "wid_123", response.parsed_body.dig("data", "id")
  end

  test "validates required fields" do
    post "/widgets", params: { color: "red" }, as: :json

    assert_response :unprocessable_entity
    assert_equal "validation_failed", response.parsed_body.dig("error", "code")
  end

  test "returns conflict for duplicates" do
    post "/widgets?simulate=duplicate", params: { name: "red-widget", color: "red" }, as: :json

    assert_response :conflict
    assert_equal "duplicate_widget", response.parsed_body.dig("error", "code")
  end

  test "returns not found for missing widgets" do
    get "/widgets/wid_missing"

    assert_response :not_found
    assert_equal "widget_not_found", response.parsed_body.dig("error", "code")
  end

  test "returns rate limit headers" do
    get "/widgets?simulate=rate_limit"

    assert_response :too_many_requests
    assert_equal "60", response.headers["Retry-After"]
  end
end
