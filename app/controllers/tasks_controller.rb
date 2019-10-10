class TasksController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks.where(params[:user_id])
  end
  
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end 
  
  def create
    @user = User.find(params[:user_id])
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
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end 
  
  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
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
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to user_tasks_url
  end 
  
  private
    def task_params
      params.require(:task).permit(:name, :note)
    end
end
