module V1
  class ProfileController < ApplicationController
    def show
      render json: profile_payload
    end

    def update
      render json: profile_payload(display_name: params[:display_name] || "Pat Example", updated_at: "2026-03-24T12:00:00Z")
    end

    private

    def profile_payload(display_name: "Pat Example", updated_at: "2026-03-20T08:30:00Z")
      {
        data: {
          id: "usr_10",
          type: "profile",
          attributes: {
            display_name: display_name,
            timezone: "UTC",
            created_at: "2026-03-01T08:00:00Z",
            updated_at: updated_at
          }
        },
        meta: {
          request_id: request.request_id || "req_profile_123"
        },
        links: {
          self: "/v1/profile"
        }
      }
    end
  end
end
