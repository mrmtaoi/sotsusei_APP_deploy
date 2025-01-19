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
      session[:user_id] = user.id
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
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
