module V1
  module Payments
    class CapturesController < ApplicationController
      def create
        return render_conflict if request.headers["PayPal-Request-Id"] == "conflict"

        response.set_header("Location", "/v1/payments/captures/cap_901")

        render json: {
          id: "cap_901",
          status: "COMPLETED",
          amount: {
            currency_code: params.dig(:amount, :currency_code) || "USD",
            value: params.dig(:amount, :value) || "42.00"
          },
          links: [
            {
              href: "/v1/payments/captures/cap_901",
              rel: "self",
              method: "GET"
            }
          ]
        }, status: :created
      end

      private

      def render_conflict
        render json: {
          name: "IDEMPOTENCY_CONFLICT",
          message: "The request ID has already been used for a different capture payload.",
          debug_id: request.headers["X-Request-Id"] || "req_501",
          details: [
            {
              field: "PayPal-Request-Id",
              issue: "MUST_MATCH_ORIGINAL_REQUEST"
            }
          ]
        }, status: :conflict
      end
    end
  end
end
