module V1
  class OperationsController < ApplicationController
    def show
      done = params[:simulate] == "done"

      render json: {
        data: {
          id: params[:id],
          type: "operation",
          attributes: {
            status: done ? "succeeded" : "running",
            submitted_at: "2026-03-25T10:05:00Z",
            completed_at: done ? "2026-03-25T10:06:30Z" : nil
          },
          links: {
            self: "/v1/operations/#{params[:id]}"
          }
        }
      }
    end
  end
end
