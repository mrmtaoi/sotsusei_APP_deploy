#app/jobs/reminder_notification_job.rb
class ReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform
    Reminder.includes(:user).find_each do |reminder|
      next unless reminder.remind_today?

      # 通知を送信
      ReminderMailer.with(user: reminder.user, reminder: reminder).upcoming_reminder.deliver_later
    end
  end
end
