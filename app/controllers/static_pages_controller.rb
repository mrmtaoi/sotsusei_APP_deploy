class StaticPagesController < ApplicationController
  def top
    @logged_in = user_logged_in?  # ログイン状態をインスタンス変数に格納
  end

  private

  # セッションに保存されたユーザーIDでログイン状態を確認
  def user_logged_in?
    session[:user_id].present?
  end
end
