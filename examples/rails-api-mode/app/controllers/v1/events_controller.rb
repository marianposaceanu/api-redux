module V1
  class EventsController < ApplicationController
    SNAPSHOT = "snap_20260325_a"

    def index
      return render_expired_cursor if params[:cursor] == "expired_cursor"
      return render_missing_snapshot if params[:cursor].present? && params[:snapshot].blank?

      render json: page_payload
    end

    private

    def page_payload
      if params[:cursor] == "evt_102"
        {
          data: [event_resource("evt_103", "customer.archived")],
          meta: {
            snapshot: SNAPSHOT,
            cursor_state: "stable"
          },
          links: {
            self: "/v1/events?cursor=evt_102&snapshot=#{SNAPSHOT}"
          }
        }
      else
        {
          data: [
            event_resource("evt_101", "customer.created"),
            event_resource("evt_102", "customer.updated")
          ],
          meta: {
            snapshot: SNAPSHOT,
            cursor_state: "stable"
          },
          links: {
            next: "/v1/events?cursor=evt_102&snapshot=#{SNAPSHOT}"
          }
        }
      end
    end

    def event_resource(id, event_name)
      {
        id: id,
        type: "event",
        attributes: {
          name: event_name,
          occurred_at: "2026-03-25T10:15:00Z"
        }
      }
    end

    def render_expired_cursor
      render json: {
        error: {
          code: "cursor_expired",
          message: "The cursor is no longer valid for this collection.",
          restart_from: "/v1/events"
        }
      }, status: :gone
    end

    def render_missing_snapshot
      render json: {
        error: {
          code: "snapshot_required",
          message: "Follow-up cursor requests must include the original snapshot token."
        }
      }, status: :bad_request
    end
  end
end
