class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy]
  before_action :admin_user_or_correct_user, only: :show
  before_action :admin_user_or_new_user, only: :new
  
  def index
    @user = User.find(1)
    @users = User.paginate(page: params[:page], per_page: 20)
  end 
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      @user.save
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー情報が更新されませんでした。"
      render :edit
    end 
  end 
  
  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "ユーザーが削除されました。"
    redirect_to users_url
  end 
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end
