class RootController < ApplicationController
  def show
    render json: {
      links: [
        { rel: ["self"], href: "/" },
        { rel: ["orders"], href: "/orders" },
        { rel: ["customers"], href: "/customers" }
      ]
    }
  end
end
