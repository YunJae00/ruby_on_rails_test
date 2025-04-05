class ApplicationController < ActionController::API
  include Pundit::Authorization

  wrap_parameters false

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  # rescue_from StandardError, with: :handle_standard_error

  def user_not_authorized
    render json: {
      error: "Not Authorized",
      message: "You are not authorized to perform this action"
    }, status: 403
  end

  # def handle_standard_error(exception)
  #   Rails.logger.error(exception.message)
  #   Rails.logger.error(exception.backtrace.join("\n"))
  #   render json: {
  #     error: "internal_server_error",
  #     message: exception.message
  #   }, status: 500
  # end

  def handle_record_not_found(exception)
    render json: {
      error: "not_found",
      message: exception.message
    }, status: 404
  end

end
