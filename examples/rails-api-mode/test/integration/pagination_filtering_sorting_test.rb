require "test_helper"

class PaginationFilteringSortingTest < ActionDispatch::IntegrationTest
  test "returns filtered customers with pagination metadata" do
    get "/v1/customers", params: { status: "active", sort: "-created_at", page: { size: 2 } }

    assert_response :success
    assert_equal 2, response.parsed_body.dig("meta", "page_size")
    assert_equal "active", response.parsed_body.dig("meta", "filters", "status")
    assert_match(/page\[after\]=cus_202/, response.parsed_body.dig("links", "next"))
  end
end
