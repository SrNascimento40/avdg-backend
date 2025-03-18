# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_up_params, only: [:create]

  # Permitir parâmetros extras na criação de conta
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :role])
  end
end
