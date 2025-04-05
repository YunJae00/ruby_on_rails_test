module Authenticable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
  end

  def authenticate_user
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    if token.present?
      begin
        decoded = JsonWebToken.decode(token)
        if decoded.nil? || decoded[:email].nil?
          render json: { error: "invalid token payload" }, status: 401 and return
        end
        @current_user = User.find_by(email: decoded[:email])
      rescue JWT::DecodeError => e
        render json: { error: "invalid token" }, status: 401
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: "user not found" }, status: 401
      rescue JWT::ExpiredSignature => e
        render json: { error: "expired" }, status: 401
      end
    else
      render json: { error: "token required" }, status: 400
    end
  end
end
