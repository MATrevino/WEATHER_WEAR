class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.api_key = SecureRandom.hex(16)
    if user.save
      render json: UsersSerializer.new(user), status: 201
     else
      render json: {error: user.errors.full_messages }, status: 400
     end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end