class AuthController < ApplicationController
  include Authenticable

  before_action :authenticate_user, except: [ :login ]

  def login
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_email: user.email)
      render json: { token: token, user: user }
    end
  end

  def login_params
    params.permit(:email, :password)
  end
end
