module V1
  class CommentsController < ApplicationController
    def create
      response.set_header("Location", "/v1/comments/cmt_123")

      if request.headers["Prefer"].to_s.include?("return=minimal")
        response.set_header("Preference-Applied", "return=minimal")
        head :created
      else
        render json: {
          data: {
            id: "cmt_123",
            type: "comment",
            attributes: {
              body: params[:body],
              status: "published"
            }
          }
        }, status: :created
      end
    end
  end
end
