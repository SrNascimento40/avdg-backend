# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  skip_before_action :authenticate_user_from_token!, only: [:create]


  def create
    user = User.new(sign_up_params)
    if user.save
      render json: { message: 'User created successfully', user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :role])
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :phone, :role)
  end
end