require "test_helper"

class QuotaPolicyTest < ActionDispatch::IntegrationTest
  test "returns standard quota headers on successful requests" do
    get "/v1/searches", params: { q: "api design" }

    assert_response :success
    assert_equal "50", response.headers["RateLimit-Limit"]
    assert_equal "37", response.headers["RateLimit-Remaining"]
    assert_equal "60", response.headers["RateLimit-Reset"]
  end

  test "returns reset semantics when the window is exhausted" do
    get "/v1/searches", params: { simulate: "exhausted" }

    assert_response :too_many_requests
    assert_equal "0", response.headers["RateLimit-Remaining"]
    assert_equal "quota_exhausted", response.parsed_body.dig("error", "code")
  end
end
