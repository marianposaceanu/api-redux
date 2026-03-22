require "test_helper"

class ErrorsValidationTest < ActionDispatch::IntegrationTest
  test "returns a structured validation error" do
    post "/v1/registrations", params: { email: "invalid", password: "short" }, as: :json

    assert_response :unprocessable_entity
    assert_equal "validation_failed", response.parsed_body.dig("error", "code")
    assert_equal 2, response.parsed_body.dig("error", "details").length
  end

  test "creates a registration when the payload is valid" do
    post "/v1/registrations", params: { email: "pat@example.test", password: "correct horse" }, as: :json

    assert_response :created
    assert_equal "pending_verification", response.parsed_body.dig("data", "attributes", "status")
  end
end
