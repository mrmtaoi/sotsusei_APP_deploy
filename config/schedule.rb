# config/schedule.rb

every '20 18 5 * *' do
  runner "ReminderJob.perform_now"
end
