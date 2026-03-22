require "test_helper"

class WebhookSignaturesTest < ActionDispatch::IntegrationTest
  test "rejects webhooks with an invalid signature" do
    post "/v1/webhooks/payments", params: { event: "payment.captured" }, as: :json, headers: {
      "X-Signature" => "sha256=bad-signature",
      "X-Webhook-Id" => "evt_123"
    }

    assert_response :unauthorized
    assert_equal "invalid_signature", response.parsed_body.dig("error", "code")
  end

  test "rejects replayed events" do
    post "/v1/webhooks/payments", params: { event: "payment.captured" }, as: :json, headers: {
      "X-Signature" => "sha256=valid-signature",
      "X-Webhook-Id" => "evt_replayed"
    }

    assert_response :conflict
    assert_equal "replay_detected", response.parsed_body.dig("error", "code")
  end

  test "accepts valid webhook deliveries" do
    post "/v1/webhooks/payments", params: { event: "payment.captured" }, as: :json, headers: {
      "X-Signature" => "sha256=valid-signature",
      "X-Webhook-Id" => "evt_123"
    }

    assert_response :accepted
    assert_equal "accepted", response.parsed_body.dig("data", "attributes", "status")
  end
end
