module V1
  class DevicesController < ApplicationController
    def create
      render json: {
        data: {
          id: "dev_123",
          type: "device",
          attributes: {
            serial_number: params[:serial_number],
            firmware_channel: "stable",
            status: "registered"
          }
        },
        meta: {
          compatibility_policy: "ignore-unknown-request-fields"
        }
      }, status: :created
    end
  end
end
