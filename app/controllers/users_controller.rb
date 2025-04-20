class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now  # 認証メールを送信
      logger.debug "Activation email sent to: #{@user.email}"
      redirect_to root_path, notice: "アカウントを作成しました。メールをご確認ください。"
    else
      logger.debug @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end
  

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # ユーザー削除前にログアウト
    log_out if logged_in?
    @user.destroy  # ユーザー削除
    
    redirect_to welcome_path, notice: 'アカウントを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 自分のアカウント以外を編集・削除させない
  def correct_user
    redirect_to root_path, alert: "他のユーザーの情報は編集できません" unless @user == current_user
  end

  # ログアウト処理を明示的に追加する
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # ログインしているかどうかを確認するメソッド
  def logged_in?
    !current_user.nil?
  end
end
