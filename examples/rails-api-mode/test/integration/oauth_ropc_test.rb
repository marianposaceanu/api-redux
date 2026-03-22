require "test_helper"

class OauthRopcTest < ActionDispatch::IntegrationTest
  test "returns a token for the password grant example" do
    post "/oauth/token",
      params: {
        grant_type: "password",
        username: "pat@example.test",
        password: "correct horse battery staple",
        scope: "profile orders:read"
      }

    assert_response :success
    assert_equal "at_ropc_123", response.parsed_body["access_token"]
    assert_equal "rt_ropc_123", response.parsed_body["refresh_token"]
  end
end
