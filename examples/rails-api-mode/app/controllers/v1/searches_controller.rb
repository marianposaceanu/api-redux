module V1
  class SearchesController < ApplicationController
    def index
      remaining = params[:simulate] == "exhausted" ? 0 : 37

      response.set_header("RateLimit-Limit", "50")
      response.set_header("RateLimit-Remaining", remaining.to_s)
      response.set_header("RateLimit-Reset", "60")
      response.set_header("RateLimit-Policy", "50;w=60")

      if remaining.zero?
        return render json: {
          error: {
            code: "quota_exhausted",
            message: "Search quota exhausted for the current window.",
            reset_in_seconds: 60
          }
        }, status: :too_many_requests
      end

      render json: {
        data: [
          {
            id: "sr_123",
            type: "search-result",
            attributes: {
              query: params[:q] || "api design",
              title: "Designing resilient APIs"
            }
          }
        ]
      }
    end
  end
end
