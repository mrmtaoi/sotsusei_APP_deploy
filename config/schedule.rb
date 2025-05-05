# config/schedule.rb

every 1.month, at: '10:00 am' do
  runner "Reminder.send_monthly_notifications"
end


