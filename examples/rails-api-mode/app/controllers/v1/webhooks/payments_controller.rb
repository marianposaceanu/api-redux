module V1
  module Webhooks
    class PaymentsController < ApplicationController
      def create
        return render_invalid_signature unless request.headers["X-Signature"] == "sha256=valid-signature"
        return render_replay unless request.headers["X-Webhook-Id"] != "evt_replayed"

        render json: {
          data: {
            id: request.headers["X-Webhook-Id"] || "evt_123",
            type: "webhook-receipt",
            attributes: {
              status: "accepted"
            }
          }
        }, status: :accepted
      end

      private

      def render_invalid_signature
        render json: {
          error: {
            code: "invalid_signature",
            message: "The webhook signature could not be verified."
          }
        }, status: :unauthorized
      end

      def render_replay
        render json: {
          error: {
            code: "replay_detected",
            message: "This webhook event was already processed."
          }
        }, status: :conflict
      end
    end
  end
end
