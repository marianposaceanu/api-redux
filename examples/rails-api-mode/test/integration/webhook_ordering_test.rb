require "test_helper"

class WebhookOrderingTest < ActionDispatch::IntegrationTest
  test "accepts events that are ready to process" do
    post "/v1/webhooks/shipments", params: { event: "shipment.updated" }, as: :json, headers: {
      "X-Webhook-Id" => "evt_901",
      "X-Event-Sequence" => "42"
    }

    assert_response :accepted
    assert_equal "ready", response.parsed_body.dig("data", "attributes", "ordering_status")
  end

  test "defers out-of-order events until missing predecessors arrive" do
    post "/v1/webhooks/shipments", params: { event: "shipment.updated" }, as: :json, headers: {
      "X-Webhook-Id" => "evt_902",
      "X-Event-Sequence" => "44"
    }

    assert_response :accepted
    assert_equal "deferred", response.parsed_body.dig("data", "attributes", "ordering_status")
    assert_equal 43, response.parsed_body.dig("data", "attributes", "waiting_for_sequence")
  end

  test "rejects replayed events inside the dedupe window" do
    post "/v1/webhooks/shipments", params: { event: "shipment.updated" }, as: :json, headers: {
      "X-Webhook-Id" => "evt_replayed",
      "X-Event-Sequence" => "42"
    }

    assert_response :conflict
    assert_equal "replay_detected", response.parsed_body.dig("error", "code")
  end
end
