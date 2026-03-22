require "test_helper"

class ContentNegotiationTest < ActionDispatch::IntegrationTest
  test "returns the default product representation" do
    get "/v1/products/prod_123", headers: {
      "Accept" => "application/vnd.api+json"
    }

    assert_response :success
    payload = JSON.parse(response.body)

    assert_equal "USD", payload.dig("data", "attributes", "currency")
  end

  test "returns the compact profile when requested" do
    get "/v1/products/prod_123", headers: {
      "Accept" => 'application/vnd.api+json; profile="https://api.example.test/profiles/product-compact"'
    }

    assert_response :success
    payload = JSON.parse(response.body)

    assert_equal "https://api.example.test/profiles/product-compact", payload.dig("data", "meta", "profile")
    assert_nil payload.dig("data", "attributes", "currency")
  end

  test "rejects unsupported media types" do
    get "/v1/products/prod_123", headers: {
      "Accept" => "application/xml"
    }

    assert_response :not_acceptable
    assert_equal "not_acceptable", response.parsed_body.dig("error", "code")
  end
end
