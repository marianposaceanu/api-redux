require "test_helper"

class SoftDeletesTest < ActionDispatch::IntegrationTest
  test "soft deletes a project and returns its purge window" do
    delete "/v1/projects/proj_123"

    assert_response :accepted
    assert_equal "soft_deleted", response.parsed_body.dig("data", "attributes", "status")
    assert response.parsed_body.dig("data", "attributes", "purge_at").present?
  end

  test "returns a tombstone for deleted projects" do
    get "/v1/projects/proj_deleted"

    assert_response :gone
    assert_equal "project-tombstone", response.parsed_body.dig("data", "type")
    assert_equal true, response.parsed_body.dig("data", "attributes", "recoverable")
  end
end
