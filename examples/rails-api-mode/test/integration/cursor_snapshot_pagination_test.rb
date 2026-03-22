require "test_helper"

class CursorSnapshotPaginationTest < ActionDispatch::IntegrationTest
  test "returns a stable snapshot token on the first page" do
    get "/v1/events"

    assert_response :success
    assert_equal "snap_20260325_a", response.parsed_body.dig("meta", "snapshot")
    assert_match(/cursor=evt_102/, response.parsed_body.dig("links", "next"))
  end

  test "requires the original snapshot token on follow-up requests" do
    get "/v1/events", params: { cursor: "evt_102" }

    assert_response :bad_request
    assert_equal "snapshot_required", response.parsed_body.dig("error", "code")
  end

  test "rejects expired cursors" do
    get "/v1/events", params: { cursor: "expired_cursor", snapshot: "snap_20260325_a" }

    assert_response :gone
    assert_equal "cursor_expired", response.parsed_body.dig("error", "code")
  end
end
