class Reminder < ApplicationRecord
  belongs_to :kit_item, optional: true
  belongs_to :emergency_kit, optional: true
  belongs_to :stock_item, optional: true
  belongs_to :user, optional: true

  private

  def set_user_id_from_kit_item
    self.user_id ||= kit_item&.emergency_kit&.user_id
  end
end
