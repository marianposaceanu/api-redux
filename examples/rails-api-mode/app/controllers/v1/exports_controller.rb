module V1
  class ExportsController < ApplicationController
    def create
      response.set_header("Location", "/v1/operations/op_export_123")
      response.set_header("Retry-After", "10")

      render json: {
        data: {
          id: "op_export_123",
          type: "operation",
          attributes: {
            status: "accepted",
            resource: "export",
            submitted_at: "2026-03-25T10:05:00Z"
          },
          links: {
            self: "/v1/operations/op_export_123"
          }
        }
      }, status: :accepted
    end
  end
end
