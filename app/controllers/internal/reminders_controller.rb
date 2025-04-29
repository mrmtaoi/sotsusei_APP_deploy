# app/controllers/internal/reminders_controller.rb

class Internal::RemindersController < ApplicationController
    # 🔽 CSRF保護をスキップ
    skip_before_action :verify_authenticity_token
    
    before_action :check_auth
  
    def deliver
      # Rake タスクを読み込むために必要な処理
      require 'rake'  # Rakeを明示的にrequire
      Rake::Task.clear  # タスクをクリア
      Rails.application.load_tasks  # タスクをロード
  
      # reminders:send_remindersタスクを実行
      Rake::Task['reminders:send_reminders'].invoke
      head :ok
    end
  
    private
  
    def check_auth
      if params[:token] != ENV['REMINDER_TASK_TOKEN']
        Rails.logger.warn "❌ Unauthorized access attempt with token: #{params[:token]}"
        head :unauthorized
      else
        Rails.logger.info "✅ Authorized access with token: #{params[:token]}"
      end
    end
  end
  