class Reminder < ApplicationRecord
  belongs_to :kit_item, optional: true
  belongs_to :emergency_kit, optional: true
  belongs_to :stock_item, optional: true
  belongs_to :user

  before_validation :set_user_id_from_item

  # 今月のリマインダーに該当するアイテムをチェック
  def self.remind_for_current_month
    where(remind_on: Date.current.all_month)
  end

  def remind_on
    return expiration_date if expiration_date.present?
    return created_at.to_date + interval_months.months if interval_months.present?

    nil
  end

  def remind_today?
    remind_on.present? && remind_on == Date.current
  end

  private

  def set_user_id_from_item
    self.user_id ||= kit_item&.emergency_kit&.user_id
    self.user_id ||= stock_item&.user_id
  end
end
