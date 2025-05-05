# config/schedule.rb

every '35 18 5 * *' do
  command "cd /Users/aoi/sotsusei_rails7_app && docker compose exec web bundle exec bin/rails runner -e production 'ReminderJob.perform_now' >> /Users/aoi/sotsusei_rails7_app/log/cron.log 2>&1"
end

