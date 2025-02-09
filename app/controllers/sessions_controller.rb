class SessionsController < ApplicationController
  def create
    if params[:session].blank?
      flash.now[:alert] = "不正なリクエストです"
      render :new and return
    end

    # メールアドレスでユーザーを検索し、認証を試行
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      logger.debug "User authenticated successfully"
      log_in(user)  # ユーザーをセッションに保存

      # チェックボックスがオンなら記憶する
      if params[:session][:remember_me] == "1"
        remember(user)
      else
        forget(user)
      end

      flash[:notice] = "ログイン成功"
      redirect_to session[:forwarding_url] || root_path
      session.delete(:forwarding_url)
    else
      logger.debug "Authentication failed for email: #{params[:session][:email]}"
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :new
    end
  end

  def destroy
    log_out if logged_in?  # ログアウト処理（クッキー削除も含む）
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
