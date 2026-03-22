require "test_helper"

class JwtTest < ActionDispatch::IntegrationTest
  test "returns JWT claims for the example payload" do
    get "/v1/jwt/claims"

    assert_response :success
    assert_equal "usr_10", response.parsed_body["sub"]
    assert_equal "orders:read orders:write", response.parsed_body["scope"]
  end
end
