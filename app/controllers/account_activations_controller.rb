class AccountActivationsController < ApplicationController
    def edit
      logger.debug "activation_token: #{params[:activation_token]}"  # トークンをログに出力
      logger.debug "email: #{params[:email]}"  # メールアドレスもログに出力
    
      user = User.find_by(email: params[:email].downcase)  # メールアドレスでユーザーを検索
  
      if user
        logger.debug "Found user"
        logger.debug "User activated? #{user.activated?}"
        logger.debug "Authenticated? #{user.authenticated?(:activation, params[:activation_token])}"
      else
        logger.debug "No user found"
      end
    
      if user && !user.activated? && user.authenticated?(:activation, params[:activation_token])
        user.activate
        log_in user
        redirect_to user, notice: "アカウントを有効化しました！"
      else
        redirect_to root_url, alert: "無効なリンクです。"
      end
    end
  end
  