require "test_helper"

class IdempotencyKeyLifetimeTest < ActionDispatch::IntegrationTest
  test "requires an idempotency key for refund creation" do
    post "/v1/refunds", params: { amount_cents: 1200 }, as: :json

    assert_response :bad_request
    assert_equal "idempotency_key_required", response.parsed_body.dig("error", "code")
  end

  test "creates a refund and returns the key ttl policy" do
    post "/v1/refunds", params: { amount_cents: 1200 }, as: :json, headers: {
      "Idempotency-Key" => "refund-key-123"
    }

    assert_response :created
    assert_equal "86400", response.headers["Idempotency-Key-Ttl"]
    assert_equal 86_400, response.parsed_body.dig("data", "attributes", "idempotency_window_seconds")
  end

  test "explains what happens after the key expires" do
    post "/v1/refunds", params: { amount_cents: 1200 }, as: :json, headers: {
      "Idempotency-Key" => "refund-expired-key"
    }

    assert_response :conflict
    assert_equal "idempotency_key_expired", response.parsed_body.dig("error", "code")
  end
end
