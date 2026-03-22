require "test_helper"

class PaypalApiStyleGuideTest < ActionDispatch::IntegrationTest
  test "creates a capture with idempotency headers" do
    post "/v1/payments/captures",
      params: {
        authorization_id: "auth_900",
        amount: { currency_code: "USD", value: "42.00" }
      },
      as: :json,
      headers: {
        "PayPal-Request-Id" => "4db6b638-0a1d-4b8d-a2b8-e2f5cbb4f220",
        "X-Request-Id" => "req_501"
      }

    assert_response :created
    assert_equal "/v1/payments/captures/cap_901", response.headers["Location"]
    assert_equal "COMPLETED", response.parsed_body["status"]
  end

  test "returns a machine readable conflict" do
    post "/v1/payments/captures",
      params: {
        authorization_id: "auth_900",
        amount: { currency_code: "USD", value: "42.00" }
      },
      as: :json,
      headers: {
        "PayPal-Request-Id" => "conflict",
        "X-Request-Id" => "req_501"
      }

    assert_response :conflict
    assert_equal "IDEMPOTENCY_CONFLICT", response.parsed_body["name"]
  end
end
