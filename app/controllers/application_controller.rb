class ApplicationController < ActionController::API
  wrap_parameters false

  rescue_from StandardError, with: :handle_standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_standard_error(exception)
    Rails.logger.error(exception.message)
    Rails.logger.error(exception.backtrace.join("\n"))
    render json: {
      error: "internal_server_error",
      message: exception.message
    }, status: 500
  end

  def handle_record_not_found(exception)
    render json: {
      error: "not_found",
      message: exception.message
    }, status: 404
  end

end
