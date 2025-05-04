# config/schedule.rb
every 1.day, at: '1:00 am' do
  runner "ReminderNotificationJob.perform_later"
end
