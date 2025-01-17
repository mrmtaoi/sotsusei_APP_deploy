class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :user_logged_in?

  def top
  end

  private

  def user_logged_in?
    session[:user_id].present?
  end
end
