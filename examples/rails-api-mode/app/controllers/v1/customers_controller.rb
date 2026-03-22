module V1
  class CustomersController < ApplicationController
    def index
      status = params[:status] || "active"
      page_size = params.dig(:page, :size).to_i.nonzero? || 2
      sort = params[:sort] || "-created_at"

      render json: {
        data: [
          customer_resource("cus_201", "Avery Stone", status),
          customer_resource("cus_202", "Jordan Lee", status)
        ],
        meta: {
          page_size: page_size,
          total_count: 42,
          sort: sort,
          filters: {
            status: status
          }
        },
        links: {
          self: "/v1/customers?status=#{status}&sort=#{sort}&page[size]=#{page_size}",
          next: "/v1/customers?status=#{status}&sort=#{sort}&page[size]=#{page_size}&page[after]=cus_202"
        }
      }
    end

    private

    def customer_resource(id, name, status)
      {
        id: id,
        type: "customer",
        attributes: {
          full_name: name,
          status: status,
          created_at: "2026-03-01T09:00:00Z"
        }
      }
    end
  end
end
