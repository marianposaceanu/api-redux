module V1
  class InvoicesController < ApplicationController
    def show
      invoice = {
        id: params[:id],
        type: "invoice",
        attributes: filtered_attributes
      }

      render json: { data: invoice }
    end

    private

    def filtered_attributes
      attributes = {
        status: "paid",
        total_cents: 4200,
        currency: "USD",
        due_on: "2026-03-31"
      }

      requested = params.dig(:fields, :invoices).to_s.split(",").map(&:strip).reject(&:empty?)
      return attributes if requested.empty?

      attributes.slice(*requested.map(&:to_sym))
    end
  end
end
