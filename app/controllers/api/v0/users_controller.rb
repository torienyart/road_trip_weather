class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user).serializable_hash, status: :created
    else
      serialized_errors = ErrorSerializer.new(user).serializable_hash[:data][:attributes]
      render json: serialized_errors, status: 400
    end
  end


  private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end