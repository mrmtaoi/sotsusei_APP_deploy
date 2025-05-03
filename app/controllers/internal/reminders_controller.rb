# app/controllers/internal/reminders_controller.rb

class Internal::RemindersController < ApplicationController
  # 🔽 CSRF保護をスキップ
  skip_before_action :verify_authenticity_token

  before_action :check_auth

  def deliver
    require 'rake'
    Rake::Task.clear
    Rails.application.load_tasks

    task = Rake::Task['reminders:send_reminders']
    task.reenable
    task.invoke

    head :ok
  end

  private

  def check_auth
    if params[:token] == ENV['REMINDER_TASK_TOKEN']
      Rails.logger.info "✅ Authorized access with token: #{params[:token]}"
    else
      Rails.logger.warn "❌ Unauthorized access attempt with token: #{params[:token]}"
      head :unauthorized
    end
  end
end
