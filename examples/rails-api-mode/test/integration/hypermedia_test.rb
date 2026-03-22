require "test_helper"

class HypermediaTest < ActionDispatch::IntegrationTest
  test "returns API entry point links" do
    get "/"

    assert_response :success
    assert_equal "/orders", response.parsed_body.dig("links", 1, "href")
  end

  test "returns an order state machine" do
    get "/orders/ord_220"

    assert_response :success
    assert_equal "order", response.parsed_body.dig("class", 0)
    assert_equal "pay", response.parsed_body.dig("actions", 0, "name")
  end
end
