module V0
  class AppointmentsController < ApplicationController
    def index
      response.set_header("Deprecation", "true")
      response.set_header("Sunset", "Wed, 30 Sep 2026 00:00:00 GMT")
      response.set_header("Link", "</v1/appointments>; rel=\"successor-version\"")

      render json: {
        appointments: [],
        total: 0
      }
    end
  end
end
