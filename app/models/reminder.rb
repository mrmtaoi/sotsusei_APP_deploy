class Reminder < ApplicationRecord
  belongs_to :kit_item, optional: true
  belongs_to :emergency_kit, optional: true
  belongs_to :stock_item, optional: true
  belongs_to :user

  before_validation :set_user_id_from_item

  validates :user, presence: true

  # 🔽 仮想属性：通知日を動的に計算
  def remind_on
    return expiration_date if expiration_date.present?
    return created_at.to_date + interval_months.months if interval_months.present?
    nil
  end

  # 🔽 今日が通知日か？
  def remind_today?
    remind_on == Date.today
  end

  private

  def set_user_id_from_item
    self.user_id ||= kit_item&.emergency_kit&.user_id
    self.user_id ||= stock_item&.user_id
  end
end
