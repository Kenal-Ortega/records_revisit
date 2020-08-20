class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  # creates user
  # returns user and their token
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # returns user
  # test route
  # works if successful, doesn't if auth is unsuccessful
  def auto_login
    render json: @user
  end

  private

  # helper function to capture info from request body
  # don't grab other info
  # Ruby creates this helper function for you
  def user_params
    params.permit(:username, :password, :email)
  end
end
