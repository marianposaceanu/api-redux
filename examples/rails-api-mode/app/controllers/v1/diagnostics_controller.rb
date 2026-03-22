module V1
  class DiagnosticsController < ApplicationController
    def show
      correlation_id = request.headers["X-Correlation-Id"].presence || "corr_generated_123"
      response.set_header("X-Correlation-Id", correlation_id)

      render json: {
        data: {
          id: params[:id],
          type: "diagnostic",
          attributes: {
            request_id: request.request_id,
            correlation_id: correlation_id,
            traceparent: request.headers["Traceparent"],
            baggage: request.headers["Baggage"]
          }
        }
      }
    end
  end
end
