module V1
  class AppointmentsController < ApplicationController
    def index
      render json: {
        appointments: [
          {
            id: "apt_301",
            service: params[:service] || "passport-renewal",
            location: "Victoria Centre",
            starts_at: "2026-03-24T10:00:00Z",
            duration_minutes: 20
          },
          {
            id: "apt_302",
            service: params[:service] || "passport-renewal",
            location: "Westminster Hub",
            starts_at: "2026-03-24T11:30:00Z",
            duration_minutes: 20
          }
        ],
        total: 2,
        links: {
          documentation: "https://developer.example.test/appointments"
        }
      }
    end
  end
end
