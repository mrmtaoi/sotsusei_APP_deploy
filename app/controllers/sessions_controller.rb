class SessionsController < ApplicationController
  def new
    # ログインフォームの表示
  end

  def create
    user = User.find_by(email: params[:email]) # 入力されたメールアドレスでユーザーを検索
    if user && user.authenticate(params[:password]) # ユーザーが見つかり、パスワードが正しい場合
      session[:user_id] = user.id # セッションにユーザーIDを保存
      redirect_to root_path, notice: 'ログインしました。'
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
