module V1
  class ReportsController < ApplicationController
    def show
      authorization = request.headers["Authorization"].to_s
      scopes = request.headers["X-Scopes"].to_s.split

      return render_unauthorized unless authorization.start_with?("Bearer ")
      return render_forbidden unless scopes.include?("reports:read")

      render json: {
        data: {
          id: "fin_2026_q1",
          type: "report",
          attributes: {
            name: "finance-summary",
            currency: "USD",
            total_revenue_cents: 902_100
          }
        }
      }
    end

    private

    def render_unauthorized
      response.set_header("WWW-Authenticate", 'Bearer realm="api", error="invalid_token"')

      render json: {
        error: {
          code: "invalid_token",
          message: "A bearer token is required."
        }
      }, status: :unauthorized
    end

    def render_forbidden
      render json: {
        error: {
          code: "insufficient_scope",
          message: "The token does not grant reports:read.",
          required_scope: "reports:read"
        }
      }, status: :forbidden
    end
  end
end
