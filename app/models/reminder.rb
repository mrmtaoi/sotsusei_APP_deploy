class Reminder < ApplicationRecord
  belongs_to :kit_item
  belongs_to :stock_item
  belongs_to :emergency_kit

  validates :expiration_date, presence: true, allow_nil: true
  validates :interval_months, presence: true, allow_nil: true
end
