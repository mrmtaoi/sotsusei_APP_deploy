class Reminder < ApplicationRecord
  belongs_to :kit_item
  belongs_to :stock_item
  belongs_to :emergency_kit
end
