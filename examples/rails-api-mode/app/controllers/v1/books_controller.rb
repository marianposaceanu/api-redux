module V1
  class BooksController < ApplicationController
    def index
      library_id = params[:library_id]

      render json: {
        data: [
          book_resource(library_id, "book_001", "API Design Patterns"),
          book_resource(library_id, "book_002", "Practical Hypermedia")
        ],
        links: {
          self: "/v1/libraries/#{library_id}/books"
        }
      }
    end

    def show
      library_id = params[:library_id]

      render json: {
        data: book_resource(library_id, params[:id], "API Design Patterns")
      }
    end

    private

    def book_resource(library_id, id, title)
      {
        id: id,
        type: "book",
        attributes: {
          title: title,
          status: "available"
        },
        links: {
          self: "/v1/libraries/#{library_id}/books/#{id}",
          collection: "/v1/libraries/#{library_id}/books"
        }
      }
    end
  end
end
