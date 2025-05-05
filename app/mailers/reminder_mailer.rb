# app/mailers/reminder_mailer.rb
class ReminderMailer < ApplicationMailer
  def monthly_summary
    @user = params[:user]
    @stock_reminders = params[:stock_reminders]
    @kit_item_reminders = params[:kit_item_reminders]
    @emergency_kit_reminders = params[:emergency_kit_reminders]

    mail(to: @user.email, subject: '今月の防災用品リマインダー')
  end

  def self.send_monthly_notifications
    start_date = Date.current.beginning_of_month
    end_date = Date.current.end_of_month

    reminders = Reminder.where(remind_on: start_date..end_date).includes(:user, :stock_item, :kit_item, :emergency_kit)

    # ユーザーごとにリマインダーを分類して送信
    reminders.group_by(&:user).each do |user, user_reminders|
      stock_reminders = user_reminders.select { |r| r.stock_item.present? }
      kit_item_reminders = user_reminders.select { |r| r.kit_item.present? }
      emergency_kit_reminders = user_reminders.select { |r| r.emergency_kit.present? }

      # いずれかのリストに対象があれば送信
      next unless stock_reminders.any? || kit_item_reminders.any? || emergency_kit_reminders.any?

      ReminderMailer.monthly_summary(
        user: user,
        stock_reminders: stock_reminders,
        kit_item_reminders: kit_item_reminders,
        emergency_kit_reminders: emergency_kit_reminders
      ).deliver_now
    end
  end
end
