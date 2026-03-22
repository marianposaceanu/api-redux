module V1
  class RegistrationsController < ApplicationController
    def create
      errors = []
      errors << { field: "email", message: "must be present and contain @" } unless params[:email].to_s.include?("@")
      errors << { field: "password", message: "must be at least 12 characters" } if params[:password].to_s.length < 12

      return render_validation_failed(errors) if errors.any?

      render json: {
        data: {
          id: "usr_11",
          type: "registration",
          attributes: {
            email: params[:email],
            status: "pending_verification"
          }
        }
      }, status: :created
    end

    private

    def render_validation_failed(errors)
      render json: {
        error: {
          code: "validation_failed",
          message: "One or more attributes are invalid.",
          request_id: request.request_id || "req_validation_123",
          details: errors
        }
      }, status: :unprocessable_entity
    end
  end
end
