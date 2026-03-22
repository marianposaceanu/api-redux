module V1
  class ProductsController < ApplicationController
    COMPACT_PROFILE = 'https://api.example.test/profiles/product-compact'

    def show
      return render_not_acceptable if request.headers["Accept"].to_s.include?("application/xml")

      render json: {
        data: {
          id: params[:id],
          type: "product",
          attributes: compact_profile? ? compact_attributes : full_attributes,
          meta: {
            profile: compact_profile? ? COMPACT_PROFILE : "default"
          }
        }
      }, content_type: negotiated_content_type
    end

    private

    def compact_profile?
      request.headers["Accept"].to_s.include?(COMPACT_PROFILE)
    end

    def negotiated_content_type
      if compact_profile?
        %(application/vnd.api+json; profile="#{COMPACT_PROFILE}")
      else
        "application/vnd.api+json"
      end
    end

    def compact_attributes
      {
        name: "Quiet Keyboard",
        price_cents: 8900
      }
    end

    def full_attributes
      compact_attributes.merge(
        currency: "USD",
        inventory_count: 14,
        warranty_months: 24
      )
    end

    def render_not_acceptable
      render json: {
        error: {
          code: "not_acceptable",
          message: "Only JSON API profiles are supported by this endpoint."
        }
      }, status: :not_acceptable
    end
  end
end
