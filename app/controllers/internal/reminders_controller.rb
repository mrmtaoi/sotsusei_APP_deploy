# app/controllers/internal/reminders_controller.rb

class Internal::RemindersController < ApplicationController
    before_action :check_auth
  
    def deliver
      Rake::Task.clear
      Rails.application.load_tasks
      Rake::Task["reminders:send_reminders"].invoke
      head :ok
    end
  
    private
  
    def check_auth
      head :unauthorized unless params[:token] == ENV["REMINDER_TASK_TOKEN"]
    end
  end
  
  