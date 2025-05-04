#lib/tasks/reminder_notifications.rake

namespace :reminder_notifications do
    desc "Send reminders for today"
    task send_today: :environment do
      Reminder.includes(:user).find_each do |reminder|
        next unless reminder.remind_today?
  
        # 通知を送信
        ReminderMailer.with(user: reminder.user, reminder: reminder).upcoming_reminder.deliver_later
      end
    end
  end
  