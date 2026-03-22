require "test_helper"

class TracePropagationTest < ActionDispatch::IntegrationTest
  test "echoes correlation and tracing headers" do
    get "/v1/diagnostics/diag_123", headers: {
      "X-Correlation-Id" => "corr_abc123",
      "Traceparent" => "00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-00",
      "Baggage" => "tenant=blue,region=eu"
    }

    assert_response :success
    assert_equal "corr_abc123", response.headers["X-Correlation-Id"]
    assert_equal "corr_abc123", response.parsed_body.dig("data", "attributes", "correlation_id")
    assert_equal "tenant=blue,region=eu", response.parsed_body.dig("data", "attributes", "baggage")
  end
end
