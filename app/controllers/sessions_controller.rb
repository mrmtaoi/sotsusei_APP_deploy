class SessionsController < ApplicationController
  def create
    # メールアドレスでユーザーを検索
    user = User.find_by(email: params[:session][:email])

    # ユーザーが存在するか、または認証に失敗した場合の処理
    if user.nil?
      flash.now[:alert] = "メールアドレスが間違っています"
      render :new and return
    end

    logger.debug "User found: #{user.inspect}"
    logger.debug "Authenticating with password: #{params[:session][:password]}"

    # bcrypt の authenticateメソッドでパスワードの照合
    if user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "ログイン成功"
      redirect_to root_path
    else
      flash.now[:alert] = "パスワードが間違っています"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
