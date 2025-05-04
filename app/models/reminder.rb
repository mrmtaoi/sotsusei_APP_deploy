class Reminder < ApplicationRecord
  belongs_to :kit_item, optional: true
  belongs_to :emergency_kit, optional: true
  belongs_to :stock_item, optional: true
  belongs_to :user

  before_validation :set_user_id_from_item

  validates :user, presence: true

  def remind_on
    return expiration_date if expiration_date.present?
    return created_at.to_date + interval_months.months if interval_months.present?
    nil
  end

  def remind_today?
    remind_on.present? && remind_on == Time.zone.today
  end

  def remind_today?
    remind_on == Date.today
  end

  private

  def set_user_id_from_item
    self.user_id ||= kit_item&.emergency_kit&.user_id
    self.user_id ||= stock_item&.user_id
  end
end
