class ChangeIntervalMonthsToNullInReminders < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reminders, :interval_months, true
  end
end
