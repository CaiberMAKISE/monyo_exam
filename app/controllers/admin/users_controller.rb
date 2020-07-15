class Admin::UsersController < ApplicationController
    before_action :current_user
    before_action :admin_judge
    def index
        @users = User.includes(:tasks)
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(admin_user_params)
        if @user.save
            redirect_to admin_users_path, notice: 'ユーザーを作成しました'
        else
            render :new
        end
    end
    def show
        @user = User.find(params[:id])
        @tasks = Task.all.where(user_id: @user.id)
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        binding.pry
        if @user.update(admin_user_params)
            redirect_to admin_users_path, notice: "ユーザーを編集しました"
        else
            render :edit
        end
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_users_path
    end
    private
    def admin_user_params
        params.require(:user).permit(:name, :email, :password,:password_confirmation, :admin)
    end
    def admin_judge
        unless current_user.admin?
            redirect_to root_path, notice: 'あなたは管理者ではありません'
        end
    end
end
