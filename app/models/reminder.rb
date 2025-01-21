class Reminder < ApplicationRecord
  belongs_to :kit_item, optional: true
  belongs_to :emergency_kit, optional: true
  belongs_to :stock_item, optional: true
  belongs_to :user, optional: true
end
