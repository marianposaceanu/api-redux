require "test_helper"

class SparseFieldsetsTest < ActionDispatch::IntegrationTest
  test "returns all invoice fields by default" do
    get "/v1/invoices/inv_123"

    assert_response :success
    assert_equal "USD", response.parsed_body.dig("data", "attributes", "currency")
    assert_equal "2026-03-31", response.parsed_body.dig("data", "attributes", "due_on")
  end

  test "returns only requested fields when sparse fieldsets are used" do
    get "/v1/invoices/inv_123", params: { fields: { invoices: "status,total_cents" } }

    assert_response :success
    assert_equal({ "status" => "paid", "total_cents" => 4200 }, response.parsed_body.dig("data", "attributes"))
  end
end
