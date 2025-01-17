class StaticPagesController < ApplicationController
  def top
    if user_signed_in?
      # ログイン後は、適切なトップページにリダイレクト
      render 'static_pages/top'
    else
      # ログインしていない場合は、ログイン前のトップページを表示
      render 'static_pages/welcome'
    end
  end
end
