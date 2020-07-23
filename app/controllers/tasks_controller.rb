class TasksController < ApplicationController
    PER = 12
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :current_user
    before_action :authenticate_user, only: [:new, :show, :index]
    def index
        if params[:sort_priority]
            @tasks = Task.all.where(user_id: current_user.id).order(priority: :desc).order(created_at: :desc).page(params[:page]).per(PER)
        elsif params[:sort_expired]
            @tasks = Task.all.where(user_id: current_user.id).order(dead_line: :asc).page(params[:page]).per(PER)
        else
            @tasks = Task.all.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(PER)
        end
        if params[:title_key].present? && params[:status_key].present?
            @tasks = Task.title_search(params[:title_key]).where(user_id: current_user.id).status_search(params[:status_key]).page(params[:page]).per(PER)
        elsif params[:title_key].present?
            @tasks = Task.title_search(params[:title_key]).where(user_id: current_user.id).page(params[:page]).per(PER)
        elsif params[:status_key].present?
            @tasks = Task.status_search(params[:status_key]).where(user_id: current_user.id).page(params[:page]).per(PER)
        else
            @tasks = Task.all.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(PER)
        end
        if params[:label_id].present?
            @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
        end
    end
    def new
        @task = Task.new
    end
    def create
        @task = current_user.tasks.build(task_params)
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
        params.require(:task).permit(:title, :content, :dead_line, :status, :priority, { label_ids: []})
    end
    def set_task
        @task = Task.find(params[:id])
    end
end
