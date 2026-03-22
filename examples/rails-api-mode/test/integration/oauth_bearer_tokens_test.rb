require "test_helper"

class OauthBearerTokensTest < ActionDispatch::IntegrationTest
  test "issues a DPoP-bound token" do
    post "/oauth/token",
      params: { grant_type: "client_credentials", scope: "orders:read" },
      headers: {
        "DPoP" => "proof.jwt"
      }

    assert_response :success
    assert_equal "DPoP", response.parsed_body["token_type"]
  end

  test "accepts a matching DPoP proof on the resource request" do
    get "/v1/orders/ord_220",
      headers: {
        "Authorization" => "DPoP at_123",
        "DPoP" => "proof.jwt"
      }

    assert_response :success
    assert_equal "ord_220", response.parsed_body.dig("data", "id")
  end
end
