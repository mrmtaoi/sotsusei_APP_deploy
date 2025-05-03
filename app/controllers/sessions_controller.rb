class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    if params[:session].blank?
      flash.now[:alert] = "不正なリクエストです"
      render :new and return
    end

    # メールアドレスでユーザーを検索し、認証を試行
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      logger.debug "User authenticated successfully"
      log_in(user) # ユーザーをセッションに保存

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

  def google_auth
    user_info = request.env['omniauth.auth']

    user = User.find_or_create_by(email: user_info['info']['email']) do |u|
      u.name = user_info['info']['name']
      u.password = SecureRandom.hex(15)
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "ログインしました（Google）"
  end

  def destroy
    log_out if logged_in? # ログアウト処理（クッキー削除も含む）
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
