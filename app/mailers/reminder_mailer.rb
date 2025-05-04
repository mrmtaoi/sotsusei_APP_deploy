# app/mailers/reminder_mailer.rb
class ReminderMailer < ApplicationMailer
  def upcoming_reminder(reminder)
    @reminder = reminder
    @stock_item = reminder.stock_item
    @kit_item = reminder.kit_item

    # remind_onが今日であれば通知を送る
    if reminder.remind_today?
      mail(to: reminder.user.email, subject: "アイテムの期限通知")
    end
  end

  def interval_notification_kit(reminder)
    @reminder = reminder
    @kit = reminder.emergency_kit

    # remind_onが今日であれば通知を送る
    if reminder.remind_today?
      mail(to: reminder.user.email, subject: "防災バッグの定期点検のお知らせ")
    end
  end

  def interval_notification_stock(reminder)
    @reminder = reminder
    @stock_item = reminder.stock_item

    # remind_onが今日であれば通知を送る
    if reminder.remind_today?
      mail(to: reminder.user.email, subject: "備蓄品の定期点検のお知らせ")
    end
  end
end

