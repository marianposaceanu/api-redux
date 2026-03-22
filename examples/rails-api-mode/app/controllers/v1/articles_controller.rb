module V1
  class ArticlesController < ApplicationController
    CURRENT_ETAG = '"article-v3"'
    NEXT_ETAG = '"article-v4"'

    def show
      response.set_header("ETag", CURRENT_ETAG)

      render json: {
        data: article_payload("Drafting Reliable APIs", 3)
      }
    end

    def update
      unless request.headers["If-Match"] == CURRENT_ETAG
        response.set_header("ETag", CURRENT_ETAG)

        return render json: {
          error: {
            code: "stale_write",
            message: "The resource changed since the client last fetched it.",
            current_version: 3
          }
        }, status: :precondition_failed
      end

      response.set_header("ETag", NEXT_ETAG)

      render json: {
        data: article_payload(params[:title] || "Drafting Reliable APIs", 4)
      }
    end

    private

    def article_payload(title, version)
      {
        id: params[:id],
        type: "article",
        attributes: {
          title: title,
          lock_version: version,
          updated_at: "2026-03-25T10:00:00Z"
        }
      }
    end
  end
end
