class AuthController < ApplicationController
  include Authenticable

  before_action :authenticate_user, except: [ :login ]

  def login
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      token = JsonWebToken.encode(email: user.email)
      render json: { token: token }, status: 200
    else
      render json: { error: 'Invalid Credentials' }, status: 401
    end
  end

  def login_params
    params.permit(:email, :password)
  end
end
