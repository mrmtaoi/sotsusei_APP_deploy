class Reminder < ApplicationRecord
  belongs_to :kit_item, optional: true
  belongs_to :stock_item, optional: true
  belongs_to :emergency_kit, optional: true
  belongs_to :user

  validates :expiration_date, presence: true, allow_nil: true
  validates :interval_months, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
