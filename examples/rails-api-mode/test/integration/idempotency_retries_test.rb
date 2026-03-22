require "test_helper"

class IdempotencyRetriesTest < ActionDispatch::IntegrationTest
  test "creates a capture with an idempotency key" do
    post "/v1/payments/captures",
      params: {
        authorization_id: "auth_900",
        amount: { currency_code: "USD", value: "42.00" }
      },
      as: :json,
      headers: {
        "PayPal-Request-Id" => "retry-safe-key",
        "X-Request-Id" => "req_701"
      }

    assert_response :created
    assert_equal "/v1/payments/captures/cap_901", response.headers["Location"]
  end

  test "returns conflict when the same key is reused for a different payload" do
    post "/v1/payments/captures",
      params: {
        authorization_id: "auth_900",
        amount: { currency_code: "USD", value: "99.00" }
      },
      as: :json,
      headers: {
        "PayPal-Request-Id" => "conflict",
        "X-Request-Id" => "req_701"
      }

    assert_response :conflict
    assert_equal "IDEMPOTENCY_CONFLICT", response.parsed_body["name"]
  end
end
