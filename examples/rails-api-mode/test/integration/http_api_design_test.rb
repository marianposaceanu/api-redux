require "test_helper"

class HttpApiDesignTest < ActionDispatch::IntegrationTest
  test "lists orders with envelopes and pagination links" do
    get "/v1/orders", params: { state: "paid", page: { size: 2, after: "ord_102" } }

    assert_response :success
    assert_equal 2, response.parsed_body["meta"]["page_size"]
    assert_equal "/v1/orders?state=paid&page[size]=2&page[after]=ord_104", response.parsed_body.dig("links", "next")
  end

  test "creates an order" do
    post "/v1/orders", params: {
      data: {
        type: "order",
        attributes: {
          customer_id: "cus_99",
          currency: "USD",
          line_items: [
            { sku: "sku-coffee", quantity: 2 }
          ]
        }
      }
    }, as: :json

    assert_response :created
    assert_equal "/v1/orders/ord_105", response.headers["Location"]
    assert_equal "ord_105", response.parsed_body.dig("data", "id")
  end
end
