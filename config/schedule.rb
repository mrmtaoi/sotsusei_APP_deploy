# config/schedule.rb
every 1.day, at: '2:00 am' do
    rake "reminders:reminders"
  end
  