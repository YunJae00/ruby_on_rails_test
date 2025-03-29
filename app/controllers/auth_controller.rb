class AuthController < ApplicationController
  include Authenticable

  before_action :authenticate_user

  def login

  end
end
