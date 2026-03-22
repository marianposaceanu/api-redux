module V1
  class OrdersController < ApplicationController
    def index
      render json: {
        data: [
          order_resource("ord_103", 4200),
          order_resource("ord_104", 1500)
        ],
        meta: {
          page_size: params.dig(:page, :size).to_i.nonzero? || 2
        },
        links: {
          next: "/v1/orders?state=paid&page[size]=2&page[after]=ord_104"
        }
      }
    end

    def create
      response.set_header("Location", "/v1/orders/ord_105")

      render json: {
        data: {
          id: "ord_105",
          type: "order",
          attributes: {
            state: "pending",
            currency: params.dig(:data, :attributes, :currency) || "USD",
            total_cents: 2400
          },
          links: {
            self: "/v1/orders/ord_105",
            cancel: "/v1/orders/ord_105/cancel"
          }
        }
      }, status: :created
    end

    def show
      if request.headers["Authorization"].to_s.start_with?("DPoP ") && request.headers["DPoP"].blank?
        return render json: {
          error: {
            code: "dpop_proof_required",
            message: "A matching DPoP proof is required for this access token."
          }
        }, status: :unauthorized
      end

      render json: {
        data: {
          id: params[:id],
          type: "order",
          attributes: {
            state: "pending",
            currency: "USD",
            total_cents: 4200
          }
        }
      }
    end

    private

    def order_resource(id, total_cents)
      {
        id: id,
        type: "order",
        attributes: {
          state: params[:state] || "paid",
          currency: "USD",
          total_cents: total_cents
        },
        links: {
          self: "/v1/orders/#{id}"
        }
      }
    end
  end
end
