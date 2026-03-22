require "test_helper"

class RangeRequestsTest < ActionDispatch::IntegrationTest
  test "returns the full download when no range is requested" do
    get "/v1/downloads/dl_123"

    assert_response :success
    assert_equal "bytes", response.headers["Accept-Ranges"]
    assert_equal "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", response.body
  end

  test "returns partial content for byte ranges" do
    get "/v1/downloads/dl_123", headers: {
      "Range" => "bytes=0-9"
    }

    assert_response :partial_content
    assert_equal "bytes 0-9/36", response.headers["Content-Range"]
    assert_equal "ABCDEFGHIJ", response.body
  end

  test "returns 416 for invalid ranges" do
    get "/v1/downloads/dl_123", headers: {
      "Range" => "bytes=200-250"
    }

    assert_response :range_not_satisfiable
    assert_equal "bytes */36", response.headers["Content-Range"]
  end
end
