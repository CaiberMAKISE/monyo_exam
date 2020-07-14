class UsersController < ApplicationController
    before_action :tasks_redirect, only: [:new]
    before_action :current_user
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end
    def show
        @user = User.find(params[:id])
        redirect_to tasks_path unless @user.id == @current_user.id
    end
    private
    def user_params
        params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
    def tasks_redirect
        if logged_in?
            redirect_to tasks_path
        end
    end
end
