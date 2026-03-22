require "test_helper"

class VersioningDeprecationTest < ActionDispatch::IntegrationTest
  test "serves the current version" do
    get "/v1/appointments", params: { service: "passport-renewal" }

    assert_response :success
    assert_equal 2, response.parsed_body["total"]
  end

  test "marks the previous version as deprecated" do
    get "/v0/appointments", params: { service: "passport-renewal" }

    assert_response :success
    assert_equal "true", response.headers["Deprecation"]
    assert_equal "Wed, 30 Sep 2026 00:00:00 GMT", response.headers["Sunset"]
  end
end
