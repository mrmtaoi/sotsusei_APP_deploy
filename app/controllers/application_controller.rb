class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception  # ← OmniAuth の csrf_detectedエラーへの対応で追加

  include SessionsHelper
  helper_method :user_logged_in?, :current_user # current_user をヘルパーメソッドとしても使えるようにする

  private

  # ユーザーのログイン確認
  def user_logged_in?
    session[:user_id].present?
  end

  # 現在のユーザーを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ユーザーがログインしているか確認するメソッド
  def require_login
    unless user_logged_in?
      flash[:alert] = "ログインしてください。"
      redirect_to login_path
    end
  end
end
