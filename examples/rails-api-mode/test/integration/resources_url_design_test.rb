require "test_helper"

class ResourcesUrlDesignTest < ActionDispatch::IntegrationTest
  test "lists books through a nested collection route" do
    get "/v1/libraries/lib_123/books"

    assert_response :success
    assert_equal "book", response.parsed_body.dig("data", 0, "type")
    assert_equal "/v1/libraries/lib_123/books", response.parsed_body.dig("links", "self")
  end

  test "shows a single nested book resource" do
    get "/v1/libraries/lib_123/books/book_001"

    assert_response :success
    assert_equal "/v1/libraries/lib_123/books/book_001", response.parsed_body.dig("data", "links", "self")
  end
end
