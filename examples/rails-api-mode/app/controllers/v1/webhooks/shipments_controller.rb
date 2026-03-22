module V1
  module Webhooks
    class ShipmentsController < ApplicationController
      def create
        return render_replay if request.headers["X-Webhook-Id"] == "evt_replayed"
        return render_deferred if request.headers["X-Event-Sequence"] == "44"

        render json: {
          data: {
            id: request.headers["X-Webhook-Id"] || "evt_901",
            type: "webhook-receipt",
            attributes: {
              ordering_status: "ready",
              dedupe_window_seconds: 86_400
            }
          }
        }, status: :accepted
      end

      private

      def render_replay
        render json: {
          error: {
            code: "replay_detected",
            message: "This webhook event is still inside the deduplication window.",
            dedupe_window_seconds: 86_400
          }
        }, status: :conflict
      end

      def render_deferred
        render json: {
          data: {
            id: request.headers["X-Webhook-Id"] || "evt_902",
            type: "webhook-receipt",
            attributes: {
              ordering_status: "deferred",
              waiting_for_sequence: 43,
              dedupe_window_seconds: 86_400
            }
          }
        }, status: :accepted
      end
    end
  end
end
