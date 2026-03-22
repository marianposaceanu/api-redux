require "test_helper"

class SchemaEvolutionTest < ActionDispatch::IntegrationTest
  test "ignores unknown request fields while preserving known ones" do
    post "/v1/devices", params: {
      serial_number: "sn_123",
      experimental_hint: "future-client-field"
    }, as: :json

    assert_response :created
    assert_equal "sn_123", response.parsed_body.dig("data", "attributes", "serial_number")
    assert_equal "ignore-unknown-request-fields", response.parsed_body.dig("meta", "compatibility_policy")
  end

  test "can add new response fields without breaking tolerant clients" do
    post "/v1/devices", params: { serial_number: "sn_456" }, as: :json

    assert_response :created
    assert_equal "stable", response.parsed_body.dig("data", "attributes", "firmware_channel")
  end
end
