class SessionsController < ApplicationController
  def create
    response.set_header("Set-Cookie", "session=sess_123; Path=/; HttpOnly; Secure; SameSite=Lax")

    render json: {
      user: {
        id: "usr_10",
        email: params[:email]
      }
    }, status: :created
  end
end
