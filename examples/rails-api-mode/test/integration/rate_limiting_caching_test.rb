require "test_helper"

class RateLimitingCachingTest < ActionDispatch::IntegrationTest
  test "returns a retry-after header when rate limited" do
    get "/widgets", params: { simulate: "rate_limit" }

    assert_response :too_many_requests
    assert_equal "60", response.headers["Retry-After"]
  end

  test "returns cache validators for cacheable resources" do
    get "/v1/catalog"

    assert_response :success
    assert_equal '"catalog-v14"', response.headers["ETag"]
    assert_includes response.headers["Cache-Control"], "max-age=60"
  end
end
