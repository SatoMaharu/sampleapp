class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: [:edit, :show, :update, :destroy]
  before_action :correct_user
  before_action :logged_in_user
  
  def index
    @tasks = @user.tasks.where(params[:user_id])
  end
  
  def new
    @task = Task.new
  end 
  
  def create
    @task = @user.tasks.new(task_params)
    if @task.save
      flash[:success] = "投稿されました。"
      redirect_to user_tasks_url
    else
      flash.now[:danger] = "投稿できませんでした。"
      render :new
    end
  end 
  
  def edit
  end
  
  def show
  end 
  
  def update
    @task.update_attributes(task_params)
    if @task.save
      flash[:success] = "投稿が編集されました。"
      redirect_to user_tasks_url
    else
      flash.now[:danger] = "投稿が編集されませんでした。"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to user_tasks_url
  end 
  
  private
    def task_params
      params.require(:task).permit(:name, :note)
    end
end
