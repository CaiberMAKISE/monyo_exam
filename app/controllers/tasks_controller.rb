class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
        if params[:sort_expired]
            @tasks = Task.all.order(dead_line: :asc)
        else
            @tasks = Task.all.order(created_at: :desc)
        end
        if params[:title_key].present? && params[:status_key].present?
            @tasks = Task.title_search(params[:title_key]).status_search(params[:status_key])
        elsif params[:title_key].present?
            @tasks = Task.title_search(params[:title_key])
        elsif params[:status_key].present?
            @tasks = Task.status_search(params[:status_key])
        else
            render :index
        end
    end
    def new
        @task = Task.new
    end
    def create
        @task = Task.new(task_params)
        if @task.save
            redirect_to tasks_path, notice: "タスクを登録しました。"
        else
            render :new
        end
    end
    def show
    end
    def edit
    end
    def update
        if @task.update(task_params)
            redirect_to tasks_path, notice: "タスクを編集しました。"
        else
            render :edit
        end
    end
    def destroy
        @task.destroy
        redirect_to tasks_path, notice:"タスクを削除しました。"
    end
    private
    def task_params
        params.require(:task).permit(:title, :content, :dead_line, :status)
    end
    def set_task
        @task = Task.find(params[:id])
    end
end
