# app/mailers/reminder_mailer.rb
class ReminderMailer < ApplicationMailer
  def upcoming_reminder(reminder)
    @reminder = reminder
    mail(to: reminder.user.email, subject: "備蓄アイテムの期限通知")
  end

  def interval_notification_kit(kit)
    @kit = kit
    mail(to: kit.user.email, subject: "防災バッグの定期点検のお知らせ")
  end

  def interval_notification_stock(reminder)
    @stock_item = reminder.stock_item
    mail(to: reminder.user.email, subject: "備蓄品の定期点検のお知らせ")
  end  
end
