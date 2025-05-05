#app/jobs/reminder_job.rb
class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    start_date = Date.current.beginning_of_month
    end_date = Date.current.end_of_month
    target_month = Date.current

    User.find_each do |user|
      user_reminders = Reminder.includes(:stock_item, :kit_item, :emergency_kit).where(user: user)

      stock_item_reminders = []
      kit_item_reminders = []
      emergency_kit_reminders = []

      user_reminders.each do |reminder|
        match = false

        # expiration_date によるチェック
        if reminder.expiration_date.present? &&
           reminder.expiration_date.between?(start_date, end_date)
          match = true
        end

        # interval_months によるチェック
        if reminder.interval_months.present?
          base_date = reminder.created_at.to_date
          months_since_base = (target_month.year * 12 + target_month.month) - (base_date.year * 12 + base_date.month)
          if months_since_base >= 0 && months_since_base % reminder.interval_months == 0
            match = true
          end
        end

        next unless match

        # 紐づくモデルごとに分類
        if reminder.stock_item.present?
          stock_item_reminders << reminder
        elsif reminder.kit_item.present?
          kit_item_reminders << reminder
        elsif reminder.emergency_kit.present?
          emergency_kit_reminders << reminder
        end
      end

      # メール送信（何か1つでも該当があれば送る）
      if stock_item_reminders.any? || kit_item_reminders.any? || emergency_kit_reminders.any?
        ReminderMailer.with(
          user: user,
          stock_reminders: stock_item_reminders,
          kit_item_reminders: kit_item_reminders,
          emergency_kit_reminders: emergency_kit_reminders
        ).monthly_summary.deliver_now
      end
    end
  end
end
