class SessionsController < ApplicationController
  def new
    # ログインフォームの表示
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # bcrypt の authenticateメソッドでパスワードの照合を行なう
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_path, status: :see_other
    else
      flash.now[:alert] = '無効なメールアドレスまたはパスワードです。'
      render :new
    end
  end

  def destroy
    session.delete(:user_id) # セッションからユーザーIDを削除
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
