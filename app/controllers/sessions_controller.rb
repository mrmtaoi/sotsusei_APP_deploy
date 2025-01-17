class SessionsController < ApplicationController

# app/helpers/sessions_helper.rb
module SessionsHelper
  # ユーザーをログインさせる
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログインしているユーザーを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーがログインしているかどうか
  def logged_in?
    !current_user.nil?
  end

  # ユーザーをログアウトさせる
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
