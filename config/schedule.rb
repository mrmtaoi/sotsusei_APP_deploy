# config/schedule.rb

every '26 17 5 * *' do
  runner "Reminder.send_monthly_notifications"
end
