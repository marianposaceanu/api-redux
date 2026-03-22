require "test_helper"

class PreferHeadersTest < ActionDispatch::IntegrationTest
  test "returns the created resource by default" do
    post "/v1/comments", params: { body: "Great API docs." }, as: :json

    assert_response :created
    assert_equal "published", response.parsed_body.dig("data", "attributes", "status")
  end

  test "honors prefer return minimal" do
    post "/v1/comments", params: { body: "Great API docs." }, as: :json, headers: {
      "Prefer" => "return=minimal"
    }

    assert_response :created
    assert_equal "return=minimal", response.headers["Preference-Applied"]
    assert_empty response.body
  end
end
