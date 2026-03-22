class WidgetsController < ApplicationController
  def index
    return render_rate_limited if params[:simulate] == "rate_limit"

    render json: {
      data: [widget_payload("wid_123")]
    }
  end

  def create
    return render_validation_failed if params[:name].blank?
    return render_duplicate if params[:simulate] == "duplicate"

    response.set_header("Location", "/widgets/wid_123")
    render json: { data: widget_payload("wid_123") }, status: :created
  end

  def show
    return render_not_found if params[:id] == "wid_missing"

    render json: { data: widget_payload(params[:id]) }
  end

  def export
    render json: {
      error: {
        code: "internal_error",
        message: "The export job could not be created."
      }
    }, status: :internal_server_error
  end

  private

  def widget_payload(id)
    {
      id: id,
      name: "red-widget",
      color: "red",
      status: "ready"
    }
  end

  def render_validation_failed
    render json: {
      error: {
        code: "validation_failed",
        message: "One or more attributes are invalid.",
        details: [
          {
            field: "name",
            message: "is required"
          }
        ]
      }
    }, status: :unprocessable_entity
  end

  def render_duplicate
    render json: {
      error: {
        code: "duplicate_widget",
        message: "A widget with this name already exists."
      }
    }, status: :conflict
  end

  def render_not_found
    render json: {
      error: {
        code: "widget_not_found",
        message: "Widget wid_missing does not exist."
      }
    }, status: :not_found
  end

  def render_rate_limited
    response.set_header("Retry-After", "60")

    render json: {
      error: {
        code: "rate_limited",
        message: "Retry after 60 seconds."
      }
    }, status: :too_many_requests
  end
end
