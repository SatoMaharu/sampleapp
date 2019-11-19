class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  #beforeフィルター
    
    def set_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      else
        @user = User.find(params[:id])
      end 
    end 

    def set_task
      @task = @user.tasks.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end 
    end
    
    def logged_out_user
      if logged_in?
        flash[:success] = "すでにログインしています。"
        redirect_to current_user
      end 
    end
    
    def correct_user
      flash[:danger] = "編集権限がありません。" if redirect_to root_url unless current_user?(@user)
    end 
    
    def current_user?(user)
      user == current_user
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    def admin_user_or_correct_user
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to root_url
      end
    end
    
    def admin_user_or_new_user
      if logged_in? && !current_user.admin?
        flash[:success] = "すでにログインしています。"
        redirect_to current_user
      end
    end 
end
