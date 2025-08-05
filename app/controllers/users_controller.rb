class UsersController < ApplicationController
    before_action :authenticate_user!

    def me
      render json: current_user, status: :ok
    end
  
    def index
        @users = User.all
        render json: @users
    end

    def sign_up
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
