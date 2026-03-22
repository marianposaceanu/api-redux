require "test_helper"

class LongRunningOperationsTest < ActionDispatch::IntegrationTest
  test "accepts an export and returns an operation resource" do
    post "/v1/exports", params: { report_type: "finance-summary" }, as: :json

    assert_response :accepted
    assert_equal "/v1/operations/op_export_123", response.headers["Location"]
    assert_equal "10", response.headers["Retry-After"]
  end

  test "allows clients to poll the operation status" do
    get "/v1/operations/op_export_123"

    assert_response :success
    assert_equal "running", response.parsed_body.dig("data", "attributes", "status")
  end

  test "can return a completed operation state" do
    get "/v1/operations/op_export_123", params: { simulate: "done" }

    assert_response :success
    assert_equal "succeeded", response.parsed_body.dig("data", "attributes", "status")
  end
end
