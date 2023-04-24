class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: UserSerializer.new(user).serializable_hash, status: 200
    elsif user != nil
      serialized_errors = ErrorSerializer.incorrect_password
      render json: serialized_errors, status: 400
    else
      serialized_errors = ErrorSerializer.user_not_found
      render json: serialized_errors, status: 400
    end
  end


  private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end