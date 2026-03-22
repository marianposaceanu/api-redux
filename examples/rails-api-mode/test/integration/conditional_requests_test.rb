require "test_helper"

class ConditionalRequestsTest < ActionDispatch::IntegrationTest
  test "returns an etag for a readable resource" do
    get "/v1/articles/art_123"

    assert_response :success
    assert_equal '"article-v3"', response.headers["ETag"]
    assert_equal 3, response.parsed_body.dig("data", "attributes", "lock_version")
  end

  test "rejects stale writes with 412" do
    patch "/v1/articles/art_123", params: { title: "Fresh Title" }, as: :json, headers: { "If-Match" => '"article-v2"' }

    assert_response :precondition_failed
    assert_equal "stale_write", response.parsed_body.dig("error", "code")
    assert_equal '"article-v3"', response.headers["ETag"]
  end

  test "accepts writes when the precondition matches" do
    patch "/v1/articles/art_123", params: { title: "Fresh Title" }, as: :json, headers: { "If-Match" => '"article-v3"' }

    assert_response :success
    assert_equal '"article-v4"', response.headers["ETag"]
    assert_equal 4, response.parsed_body.dig("data", "attributes", "lock_version")
  end
end
