require "test_helper"

class GovUkApisTest < ActionDispatch::IntegrationTest
  test "lists appointment slots" do
    get "/v1/appointments", params: { service: "passport-renewal", postcode: "SW1A1AA", from: "2026-03-24" }

    assert_response :success
    assert_equal 2, response.parsed_body["total"]
    assert_equal "passport-renewal", response.parsed_body.dig("appointments", 0, "service")
  end

  test "marks the legacy endpoint as deprecated" do
    get "/v0/appointments", params: { service: "passport-renewal" }

    assert_response :success
    assert_equal "true", response.headers["Deprecation"]
    assert_equal "</v1/appointments>; rel=\"successor-version\"", response.headers["Link"]
  end
end
