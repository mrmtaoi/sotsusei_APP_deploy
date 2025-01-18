class StaticPagesController < ApplicationController
  def root_action
    if user_logged_in?
      redirect_to static_pages_top_path
    else
      redirect_to welcome_path
    end
  end

  def welcome
    # `app/views/static_pages/welcome.html.erb` が必要です。
  end

  def top
    # `app/views/static_pages/top.html.erb` が必要です。
  end
end
