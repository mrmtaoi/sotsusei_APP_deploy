namespace :send_reminder do
    desc "Send reminder email for the last reminder"
    task send_email: :environment do
      ReminderMailer.upcoming_reminder(Reminder.last).deliver_now
      puts "Reminder email sent"
    end
  end
  