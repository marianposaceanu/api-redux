require "test_helper"

class HttpCachingTest < ActionDispatch::IntegrationTest
  test "returns cache headers for catalog responses" do
    get "/v1/catalog"

    assert_response :success
    assert_equal '"catalog-v14"', response.headers["ETag"]
    assert_includes response.headers["Cache-Control"], "public"
    assert_includes response.headers["Cache-Control"], "max-age=60"
    assert_includes response.headers["Cache-Control"], "stale-while-revalidate=30"
  end

  test "returns 304 when the etag matches" do
    get "/v1/catalog", headers: { "If-None-Match" => '"catalog-v14"' }

    assert_response :not_modified
    assert_equal '"catalog-v14"', response.headers["ETag"]
  end
end
