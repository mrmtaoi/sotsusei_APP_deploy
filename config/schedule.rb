# config/schedule.rb

every '15 17 5 * *' do
  runner "Reminder.send_monthly_notifications"
end
