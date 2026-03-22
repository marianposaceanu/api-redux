require "test_helper"

class AuthenticationAuthorizationTest < ActionDispatch::IntegrationTest
  test "returns 401 when the bearer token is missing" do
    get "/v1/reports/finance"

    assert_response :unauthorized
    assert_match(/invalid_token/, response.headers["WWW-Authenticate"])
  end

  test "returns 403 when the token lacks scope" do
    get "/v1/reports/finance", headers: {
      "Authorization" => "Bearer at_123",
      "X-Scopes" => "orders:read"
    }

    assert_response :forbidden
    assert_equal "insufficient_scope", response.parsed_body.dig("error", "code")
  end

  test "returns report data when the token and scope are valid" do
    get "/v1/reports/finance", headers: {
      "Authorization" => "Bearer at_123",
      "X-Scopes" => "reports:read orders:read"
    }

    assert_response :success
    assert_equal "finance-summary", response.parsed_body.dig("data", "attributes", "name")
  end
end
