class OrdersController < ApplicationController
  def index
    render json: {
      links: [
        { rel: ["self"], href: "/" },
        { rel: ["orders"], href: "/orders" },
        { rel: ["customers"], href: "/customers" }
      ]
    }
  end

  def show
    render json: {
      class: ["order"],
      properties: {
        id: params[:id],
        state: "pending",
        total_cents: 4200
      },
      entities: [
        {
          rel: ["item"],
          properties: {
            sku: "sku-coffee",
            quantity: 2
          }
        }
      ],
      actions: [
        {
          name: "pay",
          title: "Pay for this order",
          method: "POST",
          href: "/orders/#{params[:id]}/pay",
          type: "application/json"
        },
        {
          name: "cancel",
          title: "Cancel this order",
          method: "POST",
          href: "/orders/#{params[:id]}/cancel",
          type: "application/json"
        }
      ],
      links: [
        { rel: ["self"], href: "/orders/#{params[:id]}" },
        { rel: ["collection"], href: "/orders" }
      ]
    }
  end
end
