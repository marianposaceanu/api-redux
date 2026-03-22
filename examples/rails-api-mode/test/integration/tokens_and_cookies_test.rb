require "test_helper"

class TokensAndCookiesTest < ActionDispatch::IntegrationTest
  test "creates a browser session cookie" do
    post "/sessions", params: { email: "pat@example.test", password: "correct horse battery staple" }, as: :json

    assert_response :created
    assert_match(/session=sess_123/, response.headers["Set-Cookie"])
  end

  test "exchanges a session for a narrow token" do
    post "/oauth/token",
      params: {
        grant_type: "urn:ietf:params:oauth:grant-type:token-exchange",
        subject_token: "sess_123",
        scope: "reports:read"
      }

    assert_response :success
    assert_equal "at_reports_123", response.parsed_body["access_token"]
  end
end
