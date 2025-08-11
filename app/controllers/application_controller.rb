class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permitir campos extras no Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :role])
  end

  private

  # Autenticar usuário a partir do token JWT no header
  def authenticate_user_from_token!
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Missing token' }, status: :unauthorized unless token

    begin
      # Aqui assumindo que o secret_key do Devise JWT está em credentials
      payload = JWT.decode(token, Rails.application.credentials.devise[:jwt_secret_key], true, algorithm: 'HS256').first
      @current_user = User.find_by(id: payload['sub'])
      return render json: { error: 'User not found' }, status: :unauthorized unless @current_user
    rescue JWT::DecodeError
      return render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
