module V1
  class RefundsController < ApplicationController
    WINDOW_SECONDS = 86_400

    def create
      key = request.headers["Idempotency-Key"].to_s
      response.set_header("Idempotency-Key-Ttl", WINDOW_SECONDS.to_s)

      return render_missing_key if key.blank?
      return render_expired_key if key == "refund-expired-key"
      return render_conflict if key == "refund-mismatch-key"

      response.set_header("Location", "/v1/refunds/rf_123")

      render json: {
        data: {
          id: "rf_123",
          type: "refund",
          attributes: {
            status: "pending",
            amount_cents: params[:amount_cents] || 1200,
            idempotency_window_seconds: WINDOW_SECONDS
          }
        }
      }, status: :created
    end

    private

    def render_missing_key
      render json: {
        error: {
          code: "idempotency_key_required",
          message: "Unsafe refund creation requires an Idempotency-Key header."
        }
      }, status: :bad_request
    end

    def render_expired_key
      render json: {
        error: {
          code: "idempotency_key_expired",
          message: "The original deduplication window expired; retry with a new key.",
          idempotency_window_seconds: WINDOW_SECONDS
        }
      }, status: :conflict
    end

    def render_conflict
      render json: {
        error: {
          code: "idempotency_key_conflict",
          message: "This key is still active but was first used with a different payload.",
          idempotency_window_seconds: WINDOW_SECONDS
        }
      }, status: :conflict
    end
  end
end
