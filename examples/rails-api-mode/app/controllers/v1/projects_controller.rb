module V1
  class ProjectsController < ApplicationController
    def show
      return render_tombstone if params[:id] == "proj_deleted"

      render json: {
        data: {
          id: params[:id],
          type: "project",
          attributes: {
            name: "SDK Refresh",
            status: "active"
          }
        }
      }
    end

    def destroy
      render json: {
        data: {
          id: params[:id],
          type: "project-tombstone",
          attributes: {
            status: "soft_deleted",
            deleted_at: "2026-03-26T09:00:00Z",
            purge_at: "2026-04-25T09:00:00Z",
            recoverable: true
          }
        }
      }, status: :accepted
    end

    private

    def render_tombstone
      render json: {
        data: {
          id: params[:id],
          type: "project-tombstone",
          attributes: {
            status: "deleted",
            deleted_at: "2026-03-20T12:00:00Z",
            purge_at: "2026-04-19T12:00:00Z",
            recoverable: true
          }
        }
      }, status: :gone
    end
  end
end
