class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # ユーザーを保存後にトップページにリダイレクト
      redirect_to static_pages_top_path, notice: 'ユーザーが作成されました。'
    else
      render :new
    end
  end

  def index
    @users = User.all
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
