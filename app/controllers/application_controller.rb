class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :user_logged_in?

  private

  def user_logged_in?
    session[:user_id].present?
  end
end
