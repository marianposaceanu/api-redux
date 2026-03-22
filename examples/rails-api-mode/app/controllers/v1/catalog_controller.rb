module V1
  class CatalogController < ApplicationController
    def index
      response.set_header("Cache-Control", "public, max-age=60, stale-while-revalidate=30")
      response.set_header("ETag", '"catalog-v14"')
      response.set_header("Vary", "Accept-Encoding")

      return head :not_modified if request.headers["If-None-Match"] == '"catalog-v14"'

      render json: {
        data: [
          {
            id: "sku-coffee",
            name: "Coffee Beans",
            price_cents: 1200
          }
        ]
      }
    end
  end
end
