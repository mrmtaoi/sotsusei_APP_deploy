# lib/tasks/reminder_mailer.rake

namespace :reminders do
    desc "期限や周期が来たアイテムにメール通知"
    task send_reminders: :environment do
      today = Date.today
      puts "🔔 [START] Reminder task started for #{today}"
  
      # 1. expiration_date 通知（KitItem/StockItem 両方）
      Reminder.where.not(expiration_date: nil).where(expiration_date: today).find_each do |reminder|
        puts "📅 Expiration reminder for Reminder ID=#{reminder.id}"
        ReminderMailer.upcoming_reminder(reminder).deliver_now
      end
  
      # 2. interval_months 通知
      Reminder.where.not(interval_months: nil).find_each do |reminder|
        base_date =
          if reminder.kit_item&.emergency_kit&.created_at
            reminder.kit_item.emergency_kit.created_at
          elsif reminder.stock_item&.created_at
            reminder.stock_item.created_at
          else
            nil
          end
  
        next unless base_date
  
        months_elapsed = ((today.year * 12 + today.month) - (base_date.year * 12 + base_date.month))
  
        if months_elapsed > 0 && (months_elapsed % reminder.interval_months == 0)
          puts "🔁 Interval reminder for Reminder ID=#{reminder.id} (#{months_elapsed} months elapsed)"
  
          if reminder.kit_item_id.present?
            ReminderMailer.interval_notification_kit(reminder).deliver_now
          elsif reminder.stock_item_id.present?
            ReminderMailer.interval_notification_stock(reminder).deliver_now
          end
        end
      end
  
      puts "✅ [END] Reminder task completed"
    end
  end
  