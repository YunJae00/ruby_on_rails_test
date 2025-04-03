module Authenticable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user
  end

  def authenticate_user
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: 'user not found' }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: 'invalid token' }, status: :unauthorized
    end
  end
end
