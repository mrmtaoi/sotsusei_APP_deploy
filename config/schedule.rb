# config/schedule.rb

every '10 18 5 * *' do
  runner "ReminderJob.perform_now"
end
