class Admin::LabelsController < ApplicationController
    before_action :current_user
    before_action :authenticate_user, only: [:new, :show, :index]
    def index
        @labels = Label.all
    end
    def new
        @label = Label.new
    end
    def create
        @label = Label.new(label_params)
        if @label.save
            redirect_to admin_labels_path
        else
            render :new
        end
    end
    def edit
        @label = Label.find(params[:id])
    end
    def update
        @label = Label.find(params[:id])
        if @label.update(label_params)
            redirect_to admin_labels_path, notice: "ラベルを編集しました。"
        else
            render :edit
        end
    end
    def destroy
        @label = Label.find(params[:id])
        @label.destroy
        redirect_to admin_labels_path, notice:"ラベルを削除しました。"
    end
    private
    def label_params
        params.require(:label).permit(:content)
    end
end
