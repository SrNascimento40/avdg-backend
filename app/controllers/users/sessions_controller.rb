# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]

  # Permitir parâmetros extras na criação de conta
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :role])
  end

  private

  def respond_with(resource, _opts = {})
    token = request.env['warden-jwt_auth.token']
    response.set_header('Authorization', "Bearer #{token}") if token.present?

    render json: {
      message: 'Logged in successfully',
      user: resource,
      Authorization:  "Bearer #{token}"
    }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end
end
