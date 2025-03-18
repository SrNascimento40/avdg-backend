class UsersController < ApplicationController
    def index
        @users = User.all
        render json: @users
    end

    def sign_up
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
