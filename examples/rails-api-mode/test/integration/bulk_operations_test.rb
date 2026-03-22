require "test_helper"

class BulkOperationsTest < ActionDispatch::IntegrationTest
  test "returns multi status for mixed bulk results" do
    post "/v1/bulk/customer_archives", params: {
      customer_ids: ["cus_201", "cus_locked", "cus_202"]
    }, as: :json

    assert_response :multi_status
    assert_equal 3, response.parsed_body.dig("data", "attributes", "total")
    assert_equal 1, response.parsed_body["results"].count { |result| result["status"] == 409 }
  end
end
