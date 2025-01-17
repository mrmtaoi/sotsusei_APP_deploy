class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user) # ログイン処理
      logger.debug "New user created: #{@user.inspect}" # 新規作成されたユーザーの情報をログに出力
      redirect_to root_path, notice: 'ユーザーが作成されました。'
    else
      logger.debug @user.errors.full_messages # エラーメッセージをログに出力
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
