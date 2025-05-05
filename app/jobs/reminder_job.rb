#app/jobs/reminder_job.rb
class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    # 任意のユーザーを指定（ここでは全ユーザー対象）
    User.find_each do |user|
      start_date = Date.current.beginning_of_month
      end_date = Date.current.end_of_month

      # ユーザーごとのリマインダーを取得
      user_reminders = Reminder.includes(:stock_item, :kit_item, :emergency_kit).where(user: user)

      # 各アイテムごとにフィルタリング
      stock_item_reminders = user_reminders.select do |r|
        r.stock_item&.expiration_date&.between?(start_date, end_date) ||
        r.stock_item&.confirmation_date&.between?(start_date, end_date)
      end

      kit_item_reminders = user_reminders.select do |r|
        r.kit_item&.expiration_date&.between?(start_date, end_date)
      end

      emergency_kit_reminders = user_reminders.select do |r|
        r.emergency_kit&.confirmation_date&.between?(start_date, end_date)
      end

      # メール送信
      ReminderMailer.with(
        user: user,
        stock_reminders: stock_item_reminders,
        kit_item_reminders: kit_item_reminders,
        emergency_kit_reminders: emergency_kit_reminders
      ).monthly_summary.deliver_now
    end
  end
end
